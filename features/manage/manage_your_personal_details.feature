Feature: Update the Personal details of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to update my personal details
  So I can keep my account up to date
  #- Manage - Your personal details (8.3.0.0-L 1)

  Background:
    Given I am on the home page

  @CWA-213 @smoke
  Scenario: Successfully update Your personal information
    Given I have signed in
    And I am on the Your personal details tab
    When I edit the first name and last name
    And I submit my personal details
    Then "Your personal details have been successfully updated." message is displayed
    And the first name and last name are as submitted

  @smoke
  Scenario: Successfully update Your marketing preferences
    Given I have signed in
    And I am on the Your personal details tab
    When I edit marketing preferences
    And I submit my personal details
    Then "Your personal details have been successfully updated." message is displayed
    And marketing preferences are as submitted

  @smoke
  Scenario: Successfully change password
    Given I have registered as new user without providing clubcard
    And I am on the Change your password section
    When I change password
    And I confirm changes
    Then Your personal details page is displayed
    And I can sign in with the new password successfully

  Scenario: Add clubcard to existing blinkbox books account
    Given I have registered as new user without providing clubcard
    And I am on the Your personal details tab
    When I enter valid clubcard number
    And submit my personal details
    Then clubcard added to my account
    And "Your personal details have been successfully updated." message is displayed

  Scenario: Update clubcard associated with existing blinkbox books account
    Given I have registered as new user by providing clubcard
    And I am on the Your personal details tab
    When I enter valid clubcard number
    And submit my personal details
    Then my clubcard updated
    And "Your personal details have been successfully updated." message is displayed

  @negative
  Scenario Outline: Update the Clubcard number with an invalid Clubcard
    Given I have registered as new user by providing clubcard
    And I am on the Your personal details tab
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
    And I am on the Your personal details tab
    When I attempt to update email address with already registered email address
    Then "This email address is already registered to another Blinkbox books account" message is displayed
    And my email is not updated

