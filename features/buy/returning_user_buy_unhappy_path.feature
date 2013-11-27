@buy @wip
Feature:  Unhappy path buy
  As a blinkbox books user
  I should be shown relevant error messages when submitting my payment
  So that I can edit payment details or payment method.

  Background:
    Given I have a stored card

  Scenario: Returning user buying same pay for book twice
    Given I am buying a pay for book as a logged in user
    And I pay with saved default card
    Then my payment is successful
    When I proceed to buy above book again
    Then book already in library page displayed

  Scenario: Returning user buying same free book twice
    Given I am buying a free book as a logged in user
    And I click Confirm order
    Then my payment is successful
    When I proceed to buy above book again
    Then book already in library page displayed

  Scenario Outline: Returning user adding same sample twice
    Given I have identified a <book_type> book to get sample
    When I sign in to proceed with adding sample
    Then adding sample is successful
    When I add sample of above book again
    Then book already in library page displayed

  Examples:
    |book_type|
    |pay for  |
    |free     |

  Scenario: Returning user adding a sample of already purchased pay for book
    Given I am buying a pay for book as a logged in user
    When I pay with saved default card
    Then my payment is successful
    When I add sample of above book
    Then book already in library page displayed

  Scenario: Returning user adding a sample of already purchased free book
    Given I am buying a free book as a logged in user
    And I click Confirm order
    Then my payment is successful
    When I add sample of above book
    Then book already in library page displayed

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




