@pending
Feature: Update the devices of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to update my device details
  So I can keep my account up to date

 Background:
   Given I am on the home page

  Scenario: Successfully rename a registered device
    Given I am returning user with a device linked to my account
    And I have signed in
    And I am on the Your devices tab of My account page
    When I edit my device name
    And click Rename
    Then my device should be renamed

  @manual
  Scenario: Successfully delete a registered device

  @manual
  Scenario: Trying to delete a registered device when access token has expired

  @manual
  Scenario: Trying to rename a registered device when access token has expired
