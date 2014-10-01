  @register @ie @safari
  Feature: Sign out from blinkbox books
  As a signed in user
  I want to sign out from blinkbox books
  So that I can prevent unauthorised access to my account

  Background:
    Given I am on the home page
    And I have signed in

  @smoke @production
  Scenario: Sign out from home page
    When I select sign out from the drop down menu
    Then I should be signed out successfully
    And I am redirected to Home page

  @production
  Scenario Outline: Sign out from Manage My Account pages
    Given I am on the <tab_name> tab
    When I click Sign out button
    Then I should be signed out successfully
    And I am redirected to Home page

  Examples:
    | tab_name         |
    | Personal details |
    | Saved cards      |
    | Devices          |
    | Order history    |
