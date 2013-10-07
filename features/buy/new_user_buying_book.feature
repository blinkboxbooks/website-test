@buy
Feature: New user buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it

  Background:
    Given I am on the home page
    And I have identified a best selling book to buy

  Scenario Outline: First time user buying book
    When I register to proceed with purchase
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I confirm my payment details
    Then I should be on the Payment successful page

  @smoke
  Examples: VISA
    | card_type |
    | VISA      |

  Examples: Other card types
    | card_type        |
    | Mastercard       |
    | American Express |
    | VISA Debit       |




