Feature: Sign out from Blinkbox books
  As a signed in user
  I want to sign out from Blinkbox books
  So that I can prevent unauthorised access to my account


  Background:
    Given I am on the home page
    And I have signed in

  @smoke
  Scenario: Sign out from home page
    When I select Sign out link from drop down menu
    Then I should be signed out successfully
    And I am redirected to Home page

  @smoke
  Scenario: Sign out from my account page
    Given I am on my account page
    When I click Sign out button
    Then I should be signed out successfully
    And I am redirected to Home page