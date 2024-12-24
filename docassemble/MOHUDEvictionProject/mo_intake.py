from docassemble.base.util import path_and_mimetype
import ruamel.yaml

my_yaml = ruamel.yaml.YAML(typ='safe', pure=True)

__INTAKE_YAML_PATH__ = path_and_mimetype("data/sources/placeholder_intake_criteria.yml")[0]

__all__ = ['get_intake_criteria', 'get_intake_constants']

def get_intake_constants() -> dict:
  """
    Return the intake constants, such as the asset limit which is
  """
  # fallback to empty dict if no constants are defined or error loading YAML
  constants:dict = {}

  try:
    with open(__INTAKE_YAML_PATH__, 'r') as file:
        criteria_from_yaml = my_yaml.load(file)
        return criteria_from_yaml.get('constants', {})
  except:
    return constants

def get_intake_criteria(jurisdiction: str) -> str:
    """
    Return the intake criteria for the specified jurisdiction.   
    Args:
        jurisdiction (str): The jurisdiction for which to return the intake questions.
    """
    # fallback to empty dict if no questions are defined or error loading YAML
    criteria = {"housing": "Unable to get program rules."}

    try:
        with open(__INTAKE_YAML_PATH__, 'r') as file:
            criteria_from_yaml = my_yaml.load(file)
            return criteria_from_yaml.get(jurisdiction, criteria)
    except:
        return criteria