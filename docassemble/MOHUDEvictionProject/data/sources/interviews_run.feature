@interviews_start
Feature: The interviews run without erroring

This file:
[x] Test that each interview starts without an error.
[x] Contains some additional example Steps. They use fake values and are commented out with a "#" so they won't run.

These tests are made to work with the ALKiln testing framework, an automated testing framework made under the Document Assembly Line Project.

Want to disable the tests? Want to learn more? See ALKiln's docs: https://suffolklitlab.github.io/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing

@MOHUDEvictionProject
Scenario: MOHUDEvictionProject.yml tenant runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "Landlord representation" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
    | eviction_defender_intro | True | |
    | person_answering | tenant | person_answering |
    | users[0].name.first | Uli | users[0].name.first |
    | users[0].name.last | User1 | users[0].name.first |
    | tenant_got_summons | True | |
    | method_of_summons_service['left'] | False | |
    | method_of_summons_service['mail'] | False | |
    | method_of_summons_service['other'] | False | |
    | method_of_summons_service['other_delivery'] | False | |
    | method_of_summons_service['posting'] | False | |
    | method_of_summons_service['sheriff'] | True | |
    | method_of_summons_service['minimum_number'] | None | |
    | petition_available | True | |
    | recommend_filing_answer | True | |
    | users[0].address.address | 123 Street | users[0].address.address |
    | users[0].address.city | Kansas City  | users[0].address.city |
    | users[0].address.zip | 00000 | users[0].address.zip |
    | users[0].address.unit | 1 | users[0].address.unit |
    | users[0].address.state | Missouri | users[0].address.state |
    | users[0].address.country | United States | users[0].address.country |
    | trial_court.name | Court Name | trial_court.name |
    | case_type['AC Rent and Possession'] | True | |
    | other_parties[i].name.first | Land | other_parties[0].name.first |
    | other_parties[i].name.last | Lord | other_parties[0].name.first |
    | other_parties[i].person_type | ALIndividual | other_parties[0].name.first |
    | other_parties[i].attorney.there_are_any | False | other_parties[0].attorney.there_are_any |
    
@MOHUDEvictionProject
Scenario: MOHUDEvictionProject.yml attorney (entering appearance) runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "Petition_introduction" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
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
    | method_of_summons_service['left'] | False | |
    | method_of_summons_service['mail'] | False | |
    | method_of_summons_service['other'] | False | |
    | method_of_summons_service['other_delivery'] | False | |
    | method_of_summons_service['posting'] | False | |
    | method_of_summons_service['sheriff'] | True | |
    | method_of_summons_service['minimum_number'] | None | |
    | petition_available | True | |
  
@MOHUDEvictionProject
Scenario: MOHUDEvictionProject.yml attorney (ghostwriting) runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "Petition_introduction" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
    | eviction_defender_intro | True | |
    | person_answering | attorney | person_answering |
    | representation_type | ghostwriting | representation_type |
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
  
@MOHUDEvictionProject
Scenario: MOHUDEvictionProject.yml someone else runs
  Given I start the interview at "MOHUDEvictionProject.yml"
  And the maximum seconds for each Step in this Scenario is 50
  And I get to the question id "Petition_introduction" with this data:
    | var | value | trigger |
    | acknowledged_information_use['I accept the terms of use.'] | True | |
    | acknowledged_information_use['minimum_number'] | None | |
    | eviction_defender_intro | True | |
    | person_answering | tenant_helper | person_answering |
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
  
@MOHUDMotionToContinue
Scenario: MOHUDMotionToContinue.yml runs
  Given I start the interview at "MOHUDMotionToContinue.yml"
  #And the maximum seconds for each Step in this Scenario is 50
  #And I get to the question id "downloads" with this data:
  #  | var | value | trigger |
  #  | users[0].name.first | Uli | users[0].name.first |
  #  | users[0].name.last | User1 | users[0].name.first |