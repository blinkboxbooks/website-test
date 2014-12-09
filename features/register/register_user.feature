@register @ie @safari
Feature: Register a new Blinkbox books user
  As a guest user of Blinkbox books
  I want to sign up
  So that I can buy and read books

  Background:
    Given I am a guest user

  Scenario: Happy path-register user
    Given I am on the Register page
    Then the promotion checkbox should be ticked by default
    When I enter valid personal details
    And I choose a valid password
    And I accept terms and conditions
    And I submit registration details
    Then Registration success page is displayed
    And welcome message is shown

  Scenario: Happy path register user with a valid club card number
    Given I am on the Register page
    When I enter personal details with valid clubcard number
    And I choose a valid password
    And I submit registration details by accepting terms and conditions
    Then Registration success page is displayed
    And welcome message is shown

  @negative
  Scenario: Submit registration details with already existing email address
    Given I am on the Register page
    When I enter registration details with already registered email address
    And I submit registration details by accepting terms and conditions
    Then registration is not successful
    And "This email address is already registered with blinkbox books" message is displayed
    And link to sign in with already registered email address is displayed
    When I click on link to sign in with already registered email
    Then Sign in page is displayed

  @negative
  Scenario: Submit registration details without accepting blinkbox books terms and conditions
    Given I am on the Register page
    When I enter valid registration details
    And I submit registration details by not accepting terms and conditions
    Then registration is not successful
    And "Please accept the blinkbox books terms & conditions" message is displayed

  @negative
  Scenario: Submit registration details when passwords not matching
    Given I am on the Register page
    When I enter valid personal details
    And type passwords that are not matching
    And I submit registration details by accepting terms and conditions
    Then registration is not successful
    And  "Your passwords don't match, please check and try again" message is displayed

  @negative
  Scenario: Submit registration details with password less than 6 characters
    Given I am on the Register page
    When I enter valid personal details
    And type passwords that are less than 6 characters
    And I submit registration details by accepting terms and conditions
    Then registration is not successful
    And "Your password is too short" message is displayed

  @negative
  Scenario: Submit registration details with empty password
    Given I am on the Register page
    When I enter valid personal details
    But I leave the password field empty
    And I submit registration details by accepting terms and conditions
    Then registration is not successful
    And "Please enter your password" message is displayed
    And "Your passwords don't match, please check and try again" message is displayed

  @negative
  Scenario: Submit registration details with invalid clubcard number
    Given I am on the Register page
    When I enter personal details with invalid clubcard number
    And I choose a valid password
    And I submit registration details by accepting terms and conditions
    Then registration is not successful
    And "This Tesco Clubcard number doesn't seem to be correct. Please check and try again" message is displayed

  Scenario: Tick to show password after entering passwords
    Given I am on the Register page
    When I choose a valid password
    And I tick the checkbox show password while typing
    Then the passwords should be visible

  Scenario: Check password is hidden as you type
    Given I am on the Register page
    When I choose a valid password
    Then the passwords should not be visible