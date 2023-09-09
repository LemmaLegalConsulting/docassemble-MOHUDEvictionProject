from docassemble.base.util import DADateTime
from typing import Optional

def check_improper_notice(
    is_mobile_home_owner: bool,
    rent_day: int,
    rent_period: int,
    received_notice_date: DADateTime,
    notice_to_terminate_includes_specific_day: str,
    termination_of_tenancy_date: Optional[DADateTime]=None
):
    """
    Checks if the notice to terminate tenancy is improper according to:

    * RSMo 441.060
    * Also see RSMo. 534

    Args:
        is_mobile_home_owner (bool): Whether the tenant owns their mobile home.
        rent_day (int): The day of the month that rent is due.
        rent_period (int): The number of months in the rental period.
        received_notice_date (DADateTime): The date the tenant received the notice.
        notice_to_terminate_includes_specific_day (str): Whether the notice specifies a specific day or rental period.
        termination_of_tenancy_date (Optional[DADateTime]): The date the tenancy is terminated.

    Returns:
        bool: Whether the notice is improper.
    """
    if is_mobile_home_owner:
        # Calculate the next rent due date from the received notice date
        next_rent_due_date = received_notice_date.replace(day=rent_day).plus(months=1)

        # Calculate the earliest proper termination date for this scenario
        proper_termination_date = next_rent_due_date.plus(days=60)

        # If notice specifies a specific day
        if notice_to_terminate_includes_specific_day == "specific_day":
            return termination_of_tenancy_date < proper_termination_date

        # If notice specifies a rental period
        elif notice_to_terminate_includes_specific_day == "rental_period":
            return rent_period != 12

    # For tenants who do NOT own their mobile home
    else:
        # Calculate the proper termination date for month-to-month tenancy
        proper_termination_date = received_notice_date.plus(months=1)

        # If notice specifies a specific day
        if notice_to_terminate_includes_specific_day == "specific_day":
            assert termination_of_tenancy_date is not None
            return (termination_of_tenancy_date < proper_termination_date) or (termination_of_tenancy_date.day != rent_day)

        # If notice specifies a rental period
        elif notice_to_terminate_includes_specific_day == "rental_period":
            return rent_period != 12 or proper_termination_date.day != rent_day

    # Default return in case none of the conditions are met (this should ideally never be reached)
    return False