@interviews_start
Feature: The interviews run without erroring

This file:
[x] Test that each interview starts without an error.
[x] Contains some additional example Steps. They use fake values and are commented out with a "#" so they won't run.

These tests are made to work with the ALKiln testing framework, an automated testing framework made under the Document Assembly Line Project.

Want to disable the tests? Want to learn more? See ALKiln's docs: https://suffolklitlab.github.io/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing

@1
Scenario: MOHUDEvictionProject.yml tenant runs, one plantiff, rent subsidy
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | eviction_defender_intro | True | |
    | person_answering | tenant | person_answering |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | tenant_got_summons | True | |
    | method_of_summons_service['sheriff'] | True | tenant_got_summons |
    | petition_available | True | tenant_got_summons |
    | users[0].address.address | x | |
    | users[0].address.city | y | |
    | trial_court_county_selected | Adair County | |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | a | |
    | other_parties[0].name.last | b | |
    | other_parties[i].attorney.there_are_any | True | |
    | other_parties[0].attorney[0].name.first | Bob | |
    | other_parties[0].attorney[0].name.last | Carpenter | |
    | other_parties[0].attorney[0].address.address | address | |
    | other_parties[0].attorney[0].address.city | city | |
    | other_parties.there_is_another | False | |
    | other_parties[0].address.address | address2 | |
    | other_parties[0].address.city | city2 | |
    | is_rent_subsidized | True | |
    | subsidized_housing_type | project | |
    | lease_attached | True | |
    | false_promises.there_are_any | False | | 
    | unfair_duress | True | |
    | previous_landlord_sold_property | True | |
    | notice_of_sale_provided_new_landlord | False | previous_landlord_sold_property |
    | landlord_foreclosed | False | |
    | docket_available | False | | 
    | original_hearing_date | 01/01/2000 | |
    | original_hearing_time | 1 | |
    | users.there_is_another | False | |
    | petition_states_rent_amount | True | |
    | rent_amount_owed | 100 | petition_states_rent_amount |
    | other_charges_alleged | False | |
    | landlord_agreement | False | |
    | petition_states_rent_periods | False | |
    | was_rent_paid | True | |
    | rent_amount_paid | all | was_rent_paid |
    | will_offer_payment | True | |
    | offer_attempts.there_are_any | True | |
    | offer_attempts[i].attempt_date | 01/01/2000 | |
    | offer_attempts[i].attempt_method | by letter | |
    | offer_attempts[i].was_attempt_full | True | |
    | offer_attempts[i].has_refused_payment | True | | 
    | offer_attempts[i].has_attempt_evidence | False | |
    | offer_attempts.there_is_another | False | |
    | excessive_rent | False | |
    | late_fees_assessed | True | |
    | late_fees_penalty | False | late_fees_assessed |
    | petition_states_demand_made | True | |
    | cqe_breaches['harassment'] | True | |
    | estoppel_breaches['not_up_to_code'] | True | |
    | warranty_breaches['no_heat'] | True | |
    | al_user_wants_reminders | False | |
    | x.service_method | email | |
    | x.email | test@example.com | |
  Then I download "eviction_helper"
  
  
  
  

@2
Scenario: MOHUDEvictionProject.yml attorney (entering appearance) runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | eviction_defender_intro | True | |
    | person_answering | attorney | person_answering |
    | representation_type | entering_appearance | representation_type |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | users[0].attorney[0].name.first | Attny Uli | users[0].attorney[0].name.first |
    | users[0].attorney[0].name.last | Attny 1 | users[0].attorney[0].name.first |
    | users[0].attorney[0].address.address | 123 Address St | users[0].attorney[0].address.address |
    | users[0].attorney[0].address.city | Kansas City | users[0].attorney[0].address.address |
    | users[0].attorney[0].address.state | Missouri | users[0].attorney[0].address.address |
    | tenant_got_summons | True | | 
    | method_of_summons_service['sheriff'] | True | |
    | petition_available | True | |
    | users[0].address.address | a | |
    | users[0].address.city | b | | 
    | trial_court_county_selected | Adair County| |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | Person1 | |
    | other_parties[0].name.last | Name | |
    | other_parties[i].attorney.there_are_any | False | |
    | other_parties.there_is_another | False | |
    | other_parties[0].address.address | address | |
    | other_parties[0].address.city | city | |
    | is_rent_subsidized | False | |
    | lease_attached | True | |
    | false_promises.there_are_any | False | |
    | unfair_duress | False | |
    | previous_landlord_sold_property | False | |
    | landlord_foreclosed | False | |
    | docket_available | False | |
    | original_hearing_date | 01/01/2000 | |
    | original_hearing_time | 1 | |
    | users.there_is_another | False | |
    | petition_states_rent_amount | True | |
    | rent_amount_owed | 100000 | petition_states_rent_amount |
    | landlord_agreement | False | |
    | petition_states_rent_periods | False | |
    | was_rent_paid | False | |
    | will_offer_payment | True | |
    | offer_attempts.there_are_any | False | |
    | late_fees_assessed | False | |
    | petition_states_demand_made | False | |
    | cqe_breaches['harassment'] | True | |
    | estoppel_breaches['not_up_to_code'] | True | |
    | warranty_breaches['no_heat'] | True | |
    | al_user_wants_reminders | False | |
    | x.service_method | email | |
    | x.email | test@example.com | |
  Then I download "eviction_helper"
  
  
@3
Scenario: MOHUDEvictionProject.yml attorney (ghostwriting) runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True |  |
    | al_user_wants_reminders | False |  |
    | case_type['AC Rent and Possession'] | True |  |
    | cqe_breaches['harassment'] | True |  |
    | docket_available | False |  |
    | estoppel_breaches['not_up_to_code'] | True |  |
    | eviction_defender_intro | True |  |
    | excessive_rent | False |  |
    | false_promises.there_are_any | False |  |
    | is_rent_subsidized | True |  |
    | landlord_agreement | False |  |
    | landlord_foreclosed | False |  |
    | late_fees_assessed | True |  |
    | late_fees_penalty | False | late_fees_assessed |
    | lease_attached | True |  |
    | notice_of_sale_provided_new_landlord | False | previous_landlord_sold_property |
    | offer_attempts.there_are_any | True |  |
    | offer_attempts.there_is_another | False |  |
    | offer_attempts[i].attempt_date | 01/01/2000 |  |
    | offer_attempts[i].attempt_method | by letter |  |
    | offer_attempts[i].has_attempt_evidence | False |  |
    | offer_attempts[i].has_refused_payment | True |  |
    | offer_attempts[i].was_attempt_full | True |  |
    | original_hearing_date | 01/01/2000 |  |
    | original_hearing_time | 1 |  |
    | other_parties.there_is_another | False |  |
    | other_parties[0].address.address | address2 |  |
    | other_parties[0].address.city | city2 |  |
    | other_parties[0].attorney[0].address.address | address |  |
    | other_parties[0].attorney[0].address.city | city |  |
    | other_parties[0].attorney[0].name.first | Bob |  |
    | other_parties[0].attorney[0].name.last | Carpenter |  |
    | other_parties[0].name.first | a |  |
    | other_parties[0].name.last | b |  |
    | other_parties[0].person_type | ALIndividual |  |
    | other_parties[i].attorney.there_are_any | True |  |
    | person_answering | attorney | person_answering |
    | petition_available | True |  |
    | petition_states_demand_made | True |  |
    | petition_states_rent_amount | True |  |
    | petition_states_rent_periods | False |  |
    | previous_landlord_sold_property | True |  |
    | rent_amount_owed | 100 | petition_states_rent_amount |
    | rent_amount_paid | all | was_rent_paid |
    | representation_type | ghostwriting | representation_type |
    | subsidized_housing_type | project |  |
    | tenant_got_summons | True |  |
    | trial_court_county_selected | Adair County |  |
    | unfair_duress | True |  |
    | users.there_is_another | False |  |
    | users[0].address.address | x |  |
    | users[0].address.city | y |  |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | warranty_breaches['no_heat'] | True |  |
    | was_rent_paid | True |  |
    | will_offer_payment | True |  |
    | x.email | test@example.com |  |
    | x.service_method | email |  |
  Then I download "eviction_helper"
  
@4
Scenario: MOHUDEvictionProject.yml someone else runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
    | eviction_defender_intro | True | |
    | person_answering | tenant_helper | person_answering |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | tenant_got_summons | True | |
    | method_of_summons_service['left'] | False | |
    | method_of_summons_service['mail'] | False | |
    | method_of_summons_service['other'] | False | |
    | method_of_summons_service['other_delivery'] | False | |
    | method_of_summons_service['posting'] | False | |
    | method_of_summons_service['sheriff'] | True | |
    | petition_available | True | |
    | users[0].address.address | x | |
    | users[0].address.city | y | |
    | trial_court_county_selected | Adair County | |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | a | |
    | other_parties[0].name.last | b | |
    | other_parties[i].attorney.there_are_any | True | |
    | other_parties[0].attorney[0].name.first | Bob | |
    | other_parties[0].attorney[0].name.last | Carpenter | |
    | other_parties[0].attorney[0].address.address | address | |
    | other_parties[0].attorney[0].address.city | city | |
    | other_parties.there_is_another | False | |
    | other_parties[0].address.address | address2 | |
    | other_parties[0].address.city | city2 | |
    | is_rent_subsidized | True | |
    | subsidized_housing_type | project | |
    | lease_attached | True | |
    | false_promises.there_are_any | False | | 
    | unfair_duress | True | |
    | previous_landlord_sold_property | True | |
    | notice_of_sale_provided_new_landlord | False | previous_landlord_sold_property |
    | landlord_foreclosed | False | |
    | docket_available | False | | 
    | original_hearing_date | 01/01/2000 | |
    | original_hearing_time | 1 | |
    | users.there_is_another | False | |
    | petition_states_rent_amount | True | |
    | rent_amount_owed | 100 | petition_states_rent_amount |
    | other_charges_alleged | False | |
    | landlord_agreement | False | |
    | petition_states_rent_periods | False | |
    | was_rent_paid | True | |
    | rent_amount_paid | all | was_rent_paid |
    | will_offer_payment | True | |
    | offer_attempts.there_are_any | True | |
    | offer_attempts[i].attempt_date | 01/01/2000 | |
    | offer_attempts[i].attempt_method | by letter | |
    | offer_attempts[i].was_attempt_full | True | |
    | offer_attempts[i].has_refused_payment | True | | 
    | offer_attempts[i].has_attempt_evidence | False | |
    | offer_attempts.there_is_another | False | |
    | excessive_rent | False | |
    | late_fees_assessed | True | |
    | late_fees_penalty | False | late_fees_assessed |
    | petition_states_demand_made | True | |
    | cqe_breaches['harassment'] | True | |
    | estoppel_breaches['not_up_to_code'] | True | |
    | warranty_breaches['no_heat'] | True | |
    | al_user_wants_reminders | False | |
    | x.service_method | email | |
    | x.email | test@example.com | |
  Then I download "eviction_helper"

@5
Scenario: MOHUDEvictionProject.yml tenant runs and uses case.net
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
    | eviction_defender_intro | True | |
    | person_answering | tenant_helper | person_answering |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | tenant_got_summons | True | |
    | method_of_summons_service['sheriff'] | True | |
    | petition_available | True | |
    | users[0].address.address | x | |
    | users[0].address.city | y | |
    | trial_court_county_selected | Adair County | |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | a | |
    | other_parties[0].name.last | b | |
    | other_parties[i].attorney.there_are_any | True | |
    | other_parties[0].attorney[0].name.first | Bob | |
    | other_parties[0].attorney[0].name.last | Carpenter | |
    | other_parties[0].attorney[0].address.address | address | |
    | other_parties[0].attorney[0].address.city | city | |
    | other_parties.there_is_another | False | |
    | other_parties[0].address.address | address2 | |
    | other_parties[0].address.city | city2 | |
    | is_rent_subsidized | True | |
    | subsidized_housing_type | project | |
    | lease_attached | True | |
    | false_promises.there_are_any | False | | 
    | unfair_duress | True | |
    | previous_landlord_sold_property | True | |
    | notice_of_sale_provided_new_landlord | False | previous_landlord_sold_property |
    | landlord_foreclosed | False | |
    | docket_available | True | | 
    | users.there_is_another | True | |
    | users[i].name.first | NewUser | |
    | users[i].name.last | LastName | |
    | users.there_is_another | False | | 
    | original_hearing_date | 01/01/2000 | |
    | original_hearing_time | 1 | |
    | users.there_is_another | False | |
    | petition_states_rent_amount | True | |
    | rent_amount_owed | 100 | petition_states_rent_amount |
    | other_charges_alleged | False | |
    | landlord_agreement | False | |
    | petition_states_rent_periods | False | |
    | was_rent_paid | True | |
    | rent_amount_paid | all | was_rent_paid |
    | will_offer_payment | True | |
    | offer_attempts.there_are_any | True | |
    | offer_attempts[i].attempt_date | 01/01/2000 | |
    | offer_attempts[i].attempt_method | by letter | |
    | offer_attempts[i].was_attempt_full | True | |
    | offer_attempts[i].has_refused_payment | True | | 
    | offer_attempts[i].has_attempt_evidence | False | |
    | offer_attempts.there_is_another | False | |
    | excessive_rent | False | |
    | late_fees_assessed | True | |
    | late_fees_penalty | False | late_fees_assessed |
    | petition_states_demand_made | True | |
    | cqe_breaches['harassment'] | True | |
    | estoppel_breaches['not_up_to_code'] | True | |
    | warranty_breaches['no_heat'] | True | |
    | al_user_wants_reminders | False | |
    | x.service_method | email | |
    | x.email | test@example.com | |
  Then I download "eviction_helper"
  
@6
Scenario: MOHUDMotionToContinue.yml runs
  Given I start the interview at "MOHUDMotionToContinue.yml"
  And the maximum seconds for each Step in this Scenario is 30
  And I get to the question id "download eviction_defender" with this data:
    | var | value | trigger |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | method_of_summons_service['left'] | False | |
    | method_of_summons_service['mail'] | False | |
    | method_of_summons_service['other'] | False | |
    | method_of_summons_service['other_delivery'] | False | |
    | method_of_summons_service['posting'] | False | |
    | method_of_summons_service['sheriff'] | True | |
    | method_of_summons_service['minimum_number'] | None | |
    | petition_available | True | |
    | users[0].address.address | x | |
    | users[0].address.city | y | |
    | trial_court_county_selected | Adair County | |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[0].person_type | ALIndividual | |
    | other_parties[0].name.first | a | |
    | other_parties[0].name.last | b | |
    | other_parties[i].attorney.there_are_any | True | |
    | other_parties[0].attorney[0].name.first | Bob | |
    | other_parties[0].attorney[0].name.last | Carpenter | |
    | other_parties[0].attorney[0].address.address | address | |
    | other_parties[0].attorney[0].address.city | city | |
    | other_parties.there_is_another | False | |
    | other_parties[0].address.address | address2 | |
    | other_parties[0].address.city | city2 | |
    | is_rent_subsidized | True | |
    | subsidized_housing_type | project | |
    | lease_attached | True | |
    | false_promises.there_are_any | False | | 
    | unfair_duress | True | |
    | previous_landlord_sold_property | True | |
    | notice_of_sale_provided_new_landlord | False | previous_landlord_sold_property |
    | landlord_foreclosed | False | |
    | docket_available | False | | 
    | original_hearing_date | 01/01/2000 | |
    | original_hearing_time | 1 | |
    | users.there_is_another | False | |
    | petition_states_rent_amount | True | |
    | rent_amount_owed | 100 | petition_states_rent_amount |
    | other_charges_alleged | False | |
    | landlord_agreement | False | |
    | petition_states_rent_periods | False | |
    | was_rent_paid | True | |
    | rent_amount_paid | all | was_rent_paid |
    | will_offer_payment | True | |
    | offer_attempts.there_are_any | True | |
    | offer_attempts[i].attempt_date | 01/01/2000 | |
    | offer_attempts[i].attempt_method | by letter | |
    | offer_attempts[i].was_attempt_full | True | |
    | offer_attempts[i].has_refused_payment | True | | 
    | offer_attempts[i].has_attempt_evidence | False | |
    | offer_attempts.there_is_another | False | |
    | excessive_rent | False | |
    | late_fees_assessed | True | |
    | late_fees_penalty | False | late_fees_assessed |
    | petition_states_demand_made | True | |
    | cqe_breaches['harassment'] | True | |
    | estoppel_breaches['not_up_to_code'] | True | |
    | warranty_breaches['no_heat'] | True | |
    | al_user_wants_reminders | False | |
    | x.service_method | email | |
    | x.email | test@example.com | |
  Then I download "eviction_helper"