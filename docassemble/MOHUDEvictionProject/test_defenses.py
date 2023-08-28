import datetime
from dateutil.relativedelta import relativedelta
import unittest
from unittest.mock import patch
from .defenses import check_improper_notice

class MockDADateTime:

    def __init__(self, year, month, day):
        self.datetime = datetime.datetime(year, month, day)

    def replace(self, day):
        return MockDADateTime(self.datetime.year, self.datetime.month, day)

    def plus(self, days=0, months=0):
        new_datetime = self.datetime + datetime.timedelta(days=days) + relativedelta(months=months)
        return MockDADateTime(new_datetime.year, new_datetime.month, new_datetime.day)

    @property
    def day(self):
        return self.datetime.day

class TestCheckImproperNotice(unittest.TestCase):

    def test_mobile_home_owner_specific_day_improper(self):
        # Testing for a mobile home owner with a specific termination day given before the allowed 60 days
        result = check_improper_notice(
            True,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "specific_day",
            MockDADateTime(2023, 2, 14)
        )
        self.assertTrue(result)

    def test_mobile_home_owner_specific_day_proper(self):
        # Testing for a mobile home owner with a specific termination day given after the allowed 60 days
        result = check_improper_notice(
            True,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "specific_day",
            MockDADateTime(2023, 3, 16)
        )
        self.assertFalse(result)

    def test_mobile_home_owner_rental_period_proper(self):
        # Testing for a mobile home owner with a proper month-to-month termination
        result = check_improper_notice(
            True,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "rental_period"
        )
        self.assertFalse(result)

    def test_non_mobile_home_owner_specific_day_improper(self):
        # Testing for a non-mobile home owner with a specific day given before a month
        result = check_improper_notice(
            False,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "specific_day",
            MockDADateTime(2023, 1, 14)
        )
        self.assertTrue(result)

    def test_non_mobile_home_owner_specific_day_proper(self):
        # Testing for a non-mobile home owner with a specific day given after a month and on rent day
        result = check_improper_notice(
            False,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "specific_day",
            MockDADateTime(2023, 2, 15)
        )
        self.assertFalse(result)

    def test_non_mobile_home_owner_rental_period_proper(self):
        # Testing for a non-mobile home owner with a proper month-to-month termination
        result = check_improper_notice(
            False,
            15,
            12,
            MockDADateTime(2023, 1, 1),
            "rental_period"
        )
        self.assertFalse(result)

    def test_non_mobile_home_owner_rental_period_improper(self):
        # Testing for a non-mobile home owner with an improper non month-to-month termination
        result = check_improper_notice(
            False,
            15,
            6,
            MockDADateTime(2023, 1, 1),
            "rental_period"
        )
        self.assertTrue(result)

if __name__ == '__main__':
    unittest.main()
