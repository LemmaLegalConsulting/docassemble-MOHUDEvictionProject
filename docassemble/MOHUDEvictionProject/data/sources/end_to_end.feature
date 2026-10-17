Feature: Complete MOHUDEvictionProject interview

  # Reviewed against the interview and its local includes.
  # Static ALDashboard draft curated to the chosen branch; browser validation runs in CI.
  Scenario: Complete MOHUDEvictionProject and verify the result
    Given I start the interview at "eviction_motion_to_continue.yml"
    And the maximum seconds for each Step is 300
    And the user gets to "download eviction_motion_to_continue" with this data:
      | var | value |
      | acknowledged_information_use | True |
      | eviction_motion_to_continue_intro | True |
      | original_hearing_date | 12/01/2026 |
      | original_hearing_time | 9:00 AM |
      | service_methods['us_mail'] | True |
      | service_date | 10/16/2026 |
      | users[0].name.first | Jane |
      | users[0].name.last | Smith |
      | users.there_is_another | False |
      | users[0].address.address | 123 Main St |
      | users[0].address.city | St. Louis |
      | users[0].address.state | MO |
      | users[0].address.zip | 63101 |
      | trial_court_county_selected | St. Louis, City of |
      | other_parties[0].name.first | John |
      | other_parties[0].name.last | Landlord |
      | other_parties.there_is_another | False |
      | dont_know_docket_number | False |
      | docket_number | 26SL-AC01234 |
      | trial_court.name | 22nd Judicial Circuit - St. Louis |
      | person_answering | tenant |
      | tenant_got_summons | False |
      | petition_available | False |
      | signature_date | 10/16/2026 |
      | users[0].phone_number | 3145550100 |
      | users[0].email | jane@example.com |
      | users[0].mobile_number | 3145550100 |
      | get_sms_reminders | False |
    Then I should see the phrase "All done"
