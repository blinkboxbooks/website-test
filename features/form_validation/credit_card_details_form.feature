@pending
Feature: Credit card details form validation
  In order to prevent user from submitting invalid credit card details
  As a blinkbox books product owner
  I want the ability to validate credit card form

  Background:
    Given I am returning user

  Scenario Outline: Submit Payment details with empty values
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with empty <card_field>
    Then my payment is not successful
    And "<error_message>" message is displayed

  Examples:
    | card_field   | error_message                        |
    | Card number  | Please enter your credit card number |
    | CVV          | Please enter your CVV number         |
    | Name on card | Please enter your full name          |

  Scenario Outline: Incorrect number of digits for card number of a supported card type
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with incorrect numbered card <credit_card>
    Then my payment is not successful
    And "Your credit card number must be a valid credit card number" message is displayed

  Examples:
    | credit_card       |
    | 4111              |
    | 411111111111      |
    | 411111111111111   |
    | 41111111111111111 |
    | 555555555554444   |
    | 55555555555544445 |
    | 5555              |

  Scenario Outline: Incorrect digits for CVV
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with incorrected numbered cvv <cvv> for <card_type> card
    Then my payment is not successful
    And "Your CVV number must have exactly 3 characters in length" message is displayed

  Examples:
    | card_type        | cvv  |
    | VISA             | 1234 |
    | Master card      | 1234 |

  Scenario Outline: Mall formed CVV
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with mall formed cvv <cvv>
    Then my payment is not successful
    And "Your CVV number must be a number" message is displayed

  Examples:
    | cvv |
    | abc |
    | 1a2 |
    | 12c |
    | $12 |

  Scenario: Returning user submits new payment details form with empty credit card form
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with empty credit card form
    Then my payment is not successful
    And validation error messages displayed for credit card details

  Scenario: Card number of not supported card type
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with not supported card number
    Then my payment is not successful
    And "We're sorry but your payment did not go through. Try contacting your card issuer or try using a different card." message is displayed

  @manual
  Scenario: Expiry date in the past
    Given I am buying a pay for book as a logged in user
    When I choose to pay with a new card
    And submit payment details with expiry date in the past
    Then my payment is not successful
    And "Your expiry date should not be in the past" message is displayed





