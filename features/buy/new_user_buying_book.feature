Feature: New user buying book from Blinkbox Books
 As a Guest user of Blinkbox books
 I want to the ability to complete register and buy book in one flow
 So that I can read it

 Background:
   Given I am on the home page
   And I have identified a best selling book to buy
@smoke
Scenario: Display Confirm & Pay page
  Given I choose to register
  When I complete registration successfully
  Then I should be on the Confirm & pay page

  @smoke
  Scenario Outline: First time user buying book
    Given I choose to register
    When I complete registration successfully
    Then I should be on the Confirm & pay page
    When I enter valid <card_type> card details
    And I enter valid Billing address
    And click Confirm & pay button
    Then I should be on the Payment successful page
  Examples:
    | card_type        |
    | VISA             |
    | Mastercard       |
    | American Express |
    | VISA Debit       |




