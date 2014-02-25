@buy  @pending
Feature: Returning user buying book from blinkbox books with account credit
  As a returning user of blinkbox books
  I want to the ability to buy a book with account credit
  So that I can read it

  Background:
    Given I am on the home page

  Scenario: Full payment with account credit
    Given I have £50 account credit
    When I select a book to buy with price less than £50
    And sign in to proceed with purchase
    Then Confirm and pay page displays my account credit as £50
    And my payment method is account credit

  Scenario: Part payments through account credit and credit card
    Given I have £5 account credit
    When I select a book to buy with price more than £5
    And sign in to proceed with purchase
    Then Confirm and pay page displays my account credit as £5
    And amount left to pay is displayed
    And my payment method is partial payment

  Scenario: User cancels order while buying book with account credit
    Given I have £50 account credit
    And I selected a book from home page with price less than £50
    And I have signed in to proceed with purchase
    When I cancel order
    And confirm cancel order
    Then I am redirected to Home page