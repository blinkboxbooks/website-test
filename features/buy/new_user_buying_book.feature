@buy
Feature: New user buying book from blinkbox books
  As a Guest user of blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it

  @smoke
  Scenario: Guest user buys a book and saves payment details
    Given I have selected to buy a paid book
    When I register to proceed with the purchase
    And I enter valid VISA card details
    And I enter valid Billing address
    And I choose to save the payment details
    And I submit the payment details
    Then my payment is successful

  Scenario Outline: Guest user buys a book and saves payment details
    Given I have selected to buy a paid book
    When I register to proceed with the purchase
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I choose to save the payment details
    And I submit the payment details
    Then my payment is successful

  Examples: Other card types
    | card_type  |
    | Mastercard |
    | VISA Debit |

  Scenario Outline: Guest user buys a book but does not save payment details
    Given I have selected to buy a paid book
    When I register to proceed with the purchase
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I choose not to save the payment details
    And I submit the payment details
    Then my payment is successful

  Examples: VISA
    | card_type |
    | VISA      |

  Examples: Other card types
    | card_type  |
    | Mastercard |
    | VISA Debit |

  Scenario: Guest user buys a free book
    Given I have selected to buy a free book
    When I register to proceed with the purchase
    And I click on Confirm order
    Then my payment is successful