@buy @wip
Feature:  Unhappy path buy
  As a blinkbox books user
  I should be shown relevant error messages when submitting my payment
  So that I can edit payment details or payment method.

  Background:
    Given I have a stored card

  Scenario: Returning user buying same book twice
    Given I am buying a pay for book as a logged in user
    And I pay with saved default card
    When I try to buy above book again
    Then payments page displayed with you already have this book message

  Scenario: Returning user submits empty new payment details form
    Given I am buying a pay for book as a not logged in user
    And I sign in to proceed with purchase
    When I choose to pay with a new card
    And my payment details form is empty
    And I submit payment details
    Then validation error messages should be displayed


  Scenario Outline: Returning user submits new payment card details form with invalid values
    Given I am buying a pay for book as a logged in user
    And I sign in to proceed with purchase
    When I choose to pay with a new card
    And I enter payment details with invalid <invalid_value>
    And I submit payment details
    Then <invalid_value> validation error message should be displayed

  Examples:
    | invalid_value  |
    | card number    |
    | expiry date    |
    | cvv            |
    | name on card   |
    | address line 1 |
    | address line 2 |
    | town or city   |
    | post code      |


  Scenario Outline: Payment failure
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And  I enter card details with failure <cvv>
    And I submit payment details
    Then payment failure message should be displayed

  Examples:
    | cvv |
    | 201 |
    | 301 |
    | 200 |


  Scenario Outline: Incorrect digits for CVV
    Given I am buying a pay for book as a not logged in user
    And I sign in to proceed with purchase
    When I choose to pay with a new card
    And I enter <card_type> card details with <cvv>
    And I submit payment details
    Then Invalid CVV validation error message should be displayed

  Examples:
    | card_type        | cvv  |
    | American Express | 123  |
    | VISA             | 1234 |




