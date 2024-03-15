from docassemble.base.util import DADateTime, DADict
from typing import Optional

__all__ = ["has_improper_notice", "has_improper_notice_required_by_law"]

def has_improper_notice_required_by_law(
        is_federal_emergency: bool,
        eviction_reason: DADict,
        is_subsidized_housing: bool,
        received_notice_date: DADateTime,
        notice_to_terminate_includes_specific_day: str,
        rent_day: int,
        rent_period: int,
        termination_of_tenancy_date: Optional[DADateTime]=None
) -> Optional[bool]:
    """
    Check if the notice fails to comply with the minimum notice required by
    24 CFR § 247.4, and returns True, False, or None depending on whether
    the answer can be determined.

    Args:
        is_federal_emergency (bool): Whether the tenant is protected by the federal eviction moratorium.
        eviction_reason (DADict): The reasons for eviction.
        is_subsidized_housing (bool): Whether the tenant lives in subsidized housing.
        received_notice_date (DADateTime): The date the tenant received the notice.
        notice_to_terminate_includes_specific_day (str): Whether the notice specifies a specific day or rental period.
        rent_day (int): The day of the month that rent is due.
        rent_period (int): The number of times the rental period occurs in a year (e.g., 12 for monthly rental period)
        termination_of_tenancy_date (Optional[DADateTime]): The date the tenancy is terminated.
    
    Returns:
        Optional[bool]: Whether the notice fails to provide the minimum notice required by law.
            Returns None if the basis for the eviction only requires compliance with state law
            and the lease as we do not have enough information.
    """
    if not is_subsidized_housing:
        return False
    if is_federal_emergency and eviction_reason["nonpayment of rent"]:
        proper_notice_termination_date = received_notice_date.plus(days=30)        
    elif eviction_reason["other good cause"]:
        proper_notice_termination_date = received_notice_date.plus(days=30)
    else:
        return None
    
    if notice_to_terminate_includes_specific_day == "specific_day":
        assert termination_of_tenancy_date is not None
        return termination_of_tenancy_date < proper_notice_termination_date # True if notice is improper
    elif notice_to_terminate_includes_specific_day == "rental_period":
        termination_of_tenancy_date = end_of_next_rental_period(received_notice_date, rent_day, rent_period)
        return termination_of_tenancy_date < proper_notice_termination_date
    
    return None

def has_improper_notice(
    is_mobile_home_owner: bool,
    rent_day: int,
    rent_period: int,
    received_notice_date: DADateTime,
    notice_to_terminate_includes_specific_day: str,
    petition_date: DADateTime,
    termination_of_tenancy_date: Optional[DADateTime]=None
) -> bool:
    """
    Checks if the notice to terminate tenancy is improper according to:

    * RSMo 441.060
    * Also see RSMo. 534

    Args:
        is_mobile_home_owner (bool): Whether the tenant owns their mobile home.
        rent_day (int): The day of the rental period that rent is due.
        rent_period (int): The number of times the rental period occurs in a year (e.g., 12 for monthly rental period)
        received_notice_date (DADateTime): The date the tenant received the notice.
        petition_date (DADateTime): The date the eviction petition is filed.
        notice_to_terminate_includes_specific_day (str): Whether the notice specifies a specific day or rental period.
        termination_of_tenancy_date (Optional[DADateTime]): The date the tenancy is terminated.

    Returns:
        bool: Whether the notice is improper.
    """
    if is_mobile_home_owner:
        # Proper date is at least 60 days after the upcoming rent day, but need not end on a rent day
        # Calculate the next rent due date from the received notice date
        next_rent_due_date = received_notice_date.replace(day=rent_day).plus(months=1)

        # Calculate the earliest proper termination date for this scenario
        earliest_proper_termination_date = next_rent_due_date.plus(days=60)

        if notice_to_terminate_includes_specific_day == "rental_period":
            termination_of_tenancy_date = end_of_next_rental_period(received_notice_date, rent_day, rent_period)
        elif notice_to_terminate_includes_specific_day in ["no_specific_day","something_else"]:
            termination_of_tenancy_date = petition_date
          
        # else: termination_of_tenancy_date is already set to a specific date
        
        # True means notice is improper
        return termination_of_tenancy_date < earliest_proper_termination_date

    # For tenants who do NOT own their mobile home
    else:
        # Calculate the proper termination date for month-to-month tenancy
        # Note: it must include a full rental period
        # AND end on a rent day
        earliest_proper_termination_date = end_of_next_rental_period(received_notice_date, rent_day, rent_period)

        # If notice specifies a specific day
        if notice_to_terminate_includes_specific_day == "specific_day":
            assert termination_of_tenancy_date is not None
            return (termination_of_tenancy_date < earliest_proper_termination_date) or (termination_of_tenancy_date.day != rent_day)

        # If notice specifies a rental period worth instead of a specific day
        elif notice_to_terminate_includes_specific_day == "rental_period":
            return rent_period != 12 or earliest_proper_termination_date.day != rent_day

    # Default return in case none of the conditions are met (this should ideally never be reached)
    return False


def end_of_next_rental_period(
    received_notice_date: DADateTime,
    rent_day: int,
    rent_period: int
) -> DADateTime:
    """
    Calculates the termination date from the rent day and rent period.

    Args:
        received_notice_date (DADateTime): The termination date.
        rent_day (int): The day of the rental period that rent is due.
        rent_period (int): The number of times the rental period occurs in a year (e.g., 12 for monthly rental period)
    Returns:
        DADateTime: The termination date.
    """
    if rent_period == 12:
        return received_notice_date.replace(day=rent_day).plus(months=2)
    elif rent_period == 6: # every 2 months
        return received_notice_date.replace(day=rent_day).plus(months=3)
    elif rent_period == 3: # Every 4 months
        return received_notice_date.replace(day=rent_day).plus(months=5)
    elif rent_period == 2: # Every 6 months
        return received_notice_date.replace(day=rent_day).plus(months=7)
    elif rent_period == 1: # Every 12 months
        return received_notice_date.replace(day=rent_day).plus(months=13)    
    else:
        # Frequency is probably weekly, we can only do math by days
        delta = (365 / rent_period) + (rent_day - 1) # We subtract 1 because we want to count the day of the period as the first day
        return received_notice_date.plus(days=delta)

