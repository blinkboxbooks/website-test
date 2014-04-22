Feature: Credit card details form validation
  In order to prevent user from submitting invalid credit card details
  As a blinkbox books product owner
  I want the ability to validate credit card form

  Background:
    Given I am returning user
    And I am buying a pay for book as a logged in user

  Scenario Outline: Submit Payment details with empty values
    When I choose to pay with a new card
    And submit the payment details with empty <card_field>
    Then my payment is not successful
    And "<error_message>" message is displayed

  @smoke
  Examples:
    | card_field   | error_message                        |
    | Name on card | Please enter your full name          |
    | Card number  | Please enter your credit card number |
    | CVV          | Please enter your CVV number         |

  Scenario Outline: Invalid card number
    When I choose to pay with a new card
    And submit the payment details with card number <card_number>
    Then my payment is not successful
    And "Your credit card number must be a valid credit card number" message is displayed

  Examples:
    | card_number       | details                   |
    | 4111              | less digits than required |
    | 411111111111      | less digits than required |
    | 411111111111111   | less digits than required |
    | 41111111111111111 | more digits than required |
    | 555555555554444   | less digits than required |
    | 55555555555544445 | more digits than required |
    | 5555              | less digits than required |
    | 4222222222222222  | invalid number            |

  Scenario Outline: Incorrect digits for CVV
    When I choose to pay with a new card
    And submit the payment details with cvv <cvv> for <card_type> card
    Then my payment is not successful
    And "Your CVV number must have exactly 3 characters in length" message is displayed

  Examples:
    | card_type   | cvv  |
    | VISA        | 1234 |
    | MasterCard  | 1234 |

  Scenario Outline: Malformed CVV
    When I choose to pay with a new card
    And submit the payment details with a malformed cvv <cvv>
    Then my payment is not successful
    And "Your CVV number must be a number" message is displayed

  Examples:
    | cvv |
    | abc |
    | 1a2 |
    | 12c |
    | $12 |

  Scenario: Returning user submits new payment details form with empty credit card form
    When I choose to pay with a new card
    And submit the payment details with empty credit card form
    Then my payment is not successful
    And following validation error messages are displayed for credit card details:
      | Error messages                                             |
      | Your credit card number must be a valid credit card number |
      | Please enter your credit card number                       |
      | Your CVV number must have exactly 3 characters in length   |
      | Please enter your CVV number                               |
      | Please enter your full name                                |

  Scenario: Card number of not supported card type
    When I choose to pay with a new card
    And submit the payment details with not supported card type JCB
    Then my payment is not successful
    And "We're sorry, but we couldn't complete your payment due to an issue at our end. You haven't been charged - please try again" message is displayed

  @smoke
  Scenario: Expiry date in the past
    When I choose to pay with a new card
    And submit the payment details with expiry date in the past
    Then my payment is not successful
    And "The expiry date cannot be in the past" message is displayed