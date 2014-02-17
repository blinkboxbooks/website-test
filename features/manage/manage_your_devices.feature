@pending
Feature: Update the devices of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to update my device details
  So I can keep my account up to date

  Background:
    Given I am on the home page
    And I have a device associated with my blinkbox books account
    And I have signed in

  Scenario: Successfully rename a registered device
    When I navigate to devices tab of my account
    And rename my device as "my blinkbox books device"
    And submit changes
    Then my device should be renamed to "my blinkbox books device"

  Scenario: Successfully delete a registered device
    When I navigate to devices tab of my account
    And delete my device
    And confirm delete
    Then I have no devices associated with my account

  Scenario: Cancel rename device
    When I navigate to devices tab of my account
    And rename my device as "my blinkbox books device"
    And cancel submit changes
    Then my device is not renamed

  Scenario: Cancel delete device by clicking Keep link
    When I navigate to devices tab of my account
    And delete my device
    And cancel delete device by clicking Keep link
    Then my device is not deleted

  Scenario: Cancel delete device by closing pop-up
    When I navigate to devices tab of my account
    And delete my device
    And cancel delete device by closing pop-up
    Then my device is not deleted
    
  @manual
  Scenario: Trying to delete a registered device when access token has expired

  @manual
  Scenario: Trying to rename a registered device when access token has expired