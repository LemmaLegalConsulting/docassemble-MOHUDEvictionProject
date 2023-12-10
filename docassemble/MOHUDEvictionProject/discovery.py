from docassemble.base.util import DAObject, DADict, DAList, value, showifdef, path_and_mimetype, log
import yaml
from typing import Optional, List, Dict, Union

class DiscoveryItem(DAObject):
    """
    A single item in a discovery request.

    Attributes:
        name (str): The name of the discovery item.
        description (str): A description of the discovery item.
        is_custom (bool): Whether the discovery item is a custom interrogatory.
        content (str): The content of the discovery item (e.g., interrogatory question).
                       This is only defined for "custom" interrogatories.
        default_check (bool): Indicates that the discovery item is relevant to all cases.
        soft_check (bool): Indicates that the discovery item is probably relevant, 
            but it may or may not be included dependent on priority.
        checked (bool): Whether the discovery item is checked.
        category (str): The category of the discovery item.
        priority (int): The priority of the discovery item. Higher is more important.
        conditions (List[str]): The conditions (str, inclusive) that must be met for the discovery item to be checked.
    """

    def init(self, *pargs, **kwargs):
        super().init(*pargs, **kwargs)
        if not hasattr(self, "checked"):
            self.checked = False
        
        if not hasattr(self, "soft_check"):
            self.soft_check = False

        if not hasattr(self, "default_check"):
            self.default_check = False

        if not hasattr(self, "conditions"):
            self.conditions = []
        
        if not hasattr(self, "priority"):
            self.priority = 0

        if not hasattr(self, "is_custom"):
            self.is_custom = False

    def __bool__(self):
        return self.checked
    
    def __str__(self):
        return self.name
    
    def applies(self, conditions:List[str]) -> bool:
        """
        Check if the discovery item is relevant in the interview's context.

        Note: this is not a pure function; it depends on the Docassemble interview's context.
        It will evaluate each condition assigned to the request in order with `showifdef` 
        and return True if any condition is True.

        Args:
            conditions (List[str]): The conditions (inclusive) that may be met for the discovery item to apply.
        
        Returns:
            bool: Whether the discovery item applies to the given conditions.
        """
        if hasattr(self, "default_check") and self.default_check:
            return True
        return any(showifdef(condition) for condition in self.conditions)
    
class DiscoveryDict(DADict):
    """
    A dictionary of discovery items.
    
    Methods:
        precheck_items: Pre-check discovery items based on their priority, up to a limit.
        ask_about_items: Returns the Docassemble question code for asking about discovery items.
        get_categories: Returns a list of categories for the discovery items.
        checked_values: Returns a list of checked discovery items.
        unchecked_values: Returns a list of unchecked discovery items.
        matches_from_category: Returns a list of discovery items from a given category.
        any_in_category: Returns whether any discovery items from a given category are checked.
        count_checked: Returns the number of checked discovery items.
    """
    def init(self, *pargs, **kwargs):
        super().init(*pargs, **kwargs)
        self.object_type = DiscoveryItem

        if hasattr(self, "yaml_source"):
            if not self.yaml_source.startswith("/"): # A relative path using docassemble package notation
                self._load_from_yaml(path_and_mimetype(self.yaml_source)[0])
            
            # We have the canonical path to the file
            self._load_from_yaml(self.yaml_source)


    def _load_from_yaml(self, yaml_path:str):
        """
        Load discovery items from a YAML file.
        
        Args:
            yaml_path (str): The path to the YAML file.
        """
        with open(yaml_path, 'r') as stream:
            try:
                yaml_items = yaml.safe_load(stream)
            except yaml.YAMLError as exc:
                log(exc)
        for item in yaml_items:
            dict_item = self.initializeObject(item["name"]) # ensure proper instance name
            dict_item["name"]=item["name"]
            dict_item["description"]=item.get("description", item["name"])
            dict_item["category"]=item["category"]
            dict_item["priority"]=int(item["priority"])
            dict_item["conditions"]=item.get("conditions", [])
            dict_item["default_check"]=item.get("default_check", False)

    def precheck_items(self, limit:int = 25):
        """
        Pre-check discovery items based on their priority, up to a limit.

        Args:
            limit (int): The maximum number of discovery items to pre-check. Defaults to 25 (limit in Missouri
                for interrogatories)
        """
        candidate_list = []
        for val in self.values():
            if val.applies():
                val.soft_check = True
                candidate_list.append(val)
        
        candidate_list.sort(key=lambda x: x.priority, reverse=True)

        for item in candidate_list[:limit]:
            item.checked = True

    def ask_about_items(self, show_category_notes:bool = True):
        """Returns the Docassemble question code for asking about discovery items."""
        categories = self.get_categories()

        fields = []

        for category in categories:
            if show_category_notes:
                fields.append(
                    {
                        "note": f"## {category}"
                    }
                )
            for key in self.matches_category(category):
                fields.append({
                    "label": f"### { self[key].name} [BR] {self[key].description}",
                    "label above field": True,
                    "field": self.attr_name(f"{key}.checked"),
                    "default": self[key].checked if hasattr(self[key], "checked") else False,
                    "datatype": "yesno"
                })
        return fields
    
    def get_categories(self):
        """Returns a list of categories for the discovery items."""
        return list(set([val.category for val in self.values()]))

    def checked_values(self):
        """Returns a list of checked discovery items."""
        return DAList(elements=[key for key,value in self.iteritems() if value.checked is True])
    
    def unchecked_values(self):
        """Returns a list of unchecked discovery items."""
        return DAList(elements=[key for key,value in self.iteritems() if value.checked is False])

    def matches_from_category(self, category, checked_only=True):
        """Returns a list of discovery items from a given category."""
        if checked_only:
            return DAList(elements=[key for key,value in self.iteritems() if value.category == category and value.checked is True])
        return DAList(elements=[key for key,value in self.iteritems() if value.category == category])
    
    def any_in_category(self, category):
        for key in self.elements:
            if self.elements[key].checked and self.elements[key].category == category:
                return True
        return False
    
    def count_checked(self):
        """Returns the number of checked discovery items."""
        n = 0
        for key in self.elements:
            if self.elements[key].checked: 
                n += 1
        return n
    
    def __getitem__(self, key):
        if key in self.elements:
            return self.elements[key]
        return None