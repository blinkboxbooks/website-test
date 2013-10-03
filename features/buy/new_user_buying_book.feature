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
Scenario: First time user buying book with VISA card
  Given I choose to register
  When I complete registration successfully
  Then I should be on the Confirm & pay page
  When I enter valid VISA card details
  And I enter valid Billing address
  And click Confirm & pay button
  Then I should be on the Payment successful page

  @smoke
  Scenario: First time user buying book with Mastercard card
    Given I choose to register
    When I complete registration successfully
    Then I should be on the Confirm & pay page
    When I enter valid Mastercard card details
    And I enter valid Billing address
    And click Confirm & pay button
    Then I should be on the Payment successful page

  @smoke
  Scenario: First time user buying book with American Express card
    Given I choose to register
    When I complete registration successfully
    Then I should be on the Confirm & pay page
    When I enter valid American Express card details
    And I enter valid Billing address
    And click Confirm & pay button
    Then I should be on the Payment successful page

  @smoke
  Scenario: First time user buying book with VISA Debit card
    Given I choose to register
    When I complete registration successfully
    Then I should be on the Confirm & pay page
    When I enter valid VISA Debit card details
    And I enter valid Billing address
    And click Confirm & pay button
    Then I should be on the Payment successful page



