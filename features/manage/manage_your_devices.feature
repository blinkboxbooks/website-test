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
    When I navigate to devices section of my account
    And rename my device name as "my blinkbox books device"
    And click Rename
    Then my device should be renamed to "my blinkbox books device"

  Scenario: Successfully delete a registered device
    When I navigate to devices section of my account
    And I delete my device
    And confirm delete
    Then I have no devices associated with my account

  @manual
  Scenario: Trying to delete a registered device when access token has expired

  @manual
  Scenario: Trying to rename a registered device when access token has expired