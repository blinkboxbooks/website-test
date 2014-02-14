@buy  @pending
Feature: Returning buying book from blinkbox books with account credit
  As a returning user of blinkbox books
  I want to the ability to buy a book with account credit
  So that I can read it

  Background:
    Given I am on the home page

  Scenario: User buying book by making full payment with account credit
    Given I have signed as user with £50 account credit
    When I select to buy a book with price less than £50
    Then Confirm and pay page displayed showing my account credit as £50
    And payment card details are not displayed
    When I click Confirm order
    Then my payment is successful

  Scenario: User buying book by part paying with account credit
    Given I have signed in as user with £5 account credit
    When I select to buy a book with price more than £5
    Then Confirm and pay page displayed showing my account credit as £5
    And amount left to pay is displayed
    And payment card details displayed
    When I pay with a new VISA card
    And I submit payment details
    Then my payment is successful

  Scenario: User cancels order while buying book with account credit
    Given I have signed as user with £50 account credit
    When I select to buy a book with price less than £50
    Then Confirm and pay page displayed showing my account credit as £50
    When I cancel order
    And confirm cancel order
    Then I am redirected to Home page