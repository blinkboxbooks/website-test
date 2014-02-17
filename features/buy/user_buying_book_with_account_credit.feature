@buy  @pending
Feature: Returning user buying book from blinkbox books with account credit
  As a returning user of blinkbox books
  I want to the ability to buy a book with account credit
  So that I can read it

  Background:
    Given I am on the home page

  Scenario: User buying book by making full payment with account credit
    Given I have signed as user with £50 account credit
    When I select a book to buy with price less than £50
    Then Confirm and pay page displays my account credit as £50
    And my payment method is account credit
    When I click Confirm order
    Then my payment is successful

  Scenario: User buying book by making part payments through account credit and credit card
    Given I have signed in as user with £5 account credit
    When I select a book to buy with price more than £5
    Then Confirm and pay page displays my account credit as £5
    And amount left to pay is displayed
    And my payment method is partial payment
    When I pay with a new VISA card
    And I submit payment details
    Then my payment is successful

  Scenario: User cancels order while buying book with account credit
    Given I have signed as user with £50 account credit
    When I select a book to buy with price less than £50
    Then Confirm and pay page displays my account credit as £50
    When I cancel order
    And confirm cancel order
    Then I am redirected to Home page