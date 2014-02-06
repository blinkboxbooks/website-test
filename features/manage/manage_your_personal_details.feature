Feature: Update the Personal details of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to update my personal details
  So I can keep my account up to date
  #- Manage - Personal details (8.3.0.0-L 1)

  Background:
    Given I am on the home page

  @CWA-213 @smoke
  Scenario: Successfully update Your personal information
    Given I have signed in
    And I am on the Personal details tab
    When I edit the first name and last name
    And I submit my personal details
    Then "Your personal details have been successfully updated." message is displayed
    And the first name and last name are as submitted

  @smoke @CWA-1014
  Scenario: Successfully update Your marketing preferences
    Given I have signed in
    And I am on the Personal details tab
    When I edit marketing preferences
    And I submit my personal details
    Then "Your personal details have been successfully updated." message is displayed
    And marketing preferences are as submitted

  @smoke
  Scenario: Successfully update Email address
    Given I have registered as new user without providing clubcard
    And I am on the Personal details tab
    When I edit email address
    And I submit my personal details
    Then "Your personal details have been successfully updated." message is displayed
    And email address is as submitted

  Scenario: Add clubcard to existing blinkbox books account
    Given I have registered as new user without providing clubcard
    And I am on the Personal details tab
    When I enter valid clubcard number
    And submit my personal details
    Then clubcard added to my account
    And "Your personal details have been successfully updated." message is displayed

  Scenario: Delete clubcard from existing blinkbox account
    Given I have registered as new user by providing clubcard
    And I am on the Personal details tab
    When I remove clubcard number
    And submit my personal details
    Then my clubcard field is empty
    And "Your personal details have been successfully updated." message is displayed

  Scenario: Update clubcard associated with existing blinkbox books account
    Given I have registered as new user by providing clubcard
    And I am on the Personal details tab
    When I enter valid clubcard number
    And submit my personal details
    Then my clubcard updated
    And "Your personal details have been successfully updated." message is displayed

  @negative
  Scenario Outline: Update the Clubcard number with an invalid Clubcard
    Given I have registered as new user by providing clubcard
    And I am on the Personal details tab
    When I attempt to update my clubcard with invalid <clubcard_number>
    Then "This Tesco Clubcard number doesn't seem to be correct. Please check and try again" message is displayed
    And my clubcard is not updated

  Examples:
    | clubcard_number    |
    | 123456789012345678 |
    | 634004025023057563 |
    | 634004025023057562 |

  @negative
  Scenario: Update email address using already registered email address
    Given I am returning user
    And I have signed in
    And I am on the Personal details tab
    When I attempt to update email address with already registered email address
    Then "This email address is already registered to another Blinkbox books account" message is displayed
    And my email is not updated

  Scenario Outline: Check marketing preferences status for returning in user
    Given I have <opt_status> for blinkbox books marketing
    And I have signed in
    When I am on the Personal details tab
    Then my marketing preferences checkbox is <checkbox_status>
  Examples:
    | opt_status   | checkbox_status |
    | opted in     | selected        |
    | not opted in | not selected    |