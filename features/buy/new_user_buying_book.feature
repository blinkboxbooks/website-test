Feature: New user buying book from Blinkbox Books
 As a Guest user of Blinkbox books
 I want to the ability to complete register and buy book in one flow
 So that I can read it

 Background:
   Given I have identified the book to buy
@smoke
Scenario: Display Confirm & Pay page
  Given I choose to register
  When I complete registration successfully
  Then I should be on the Confirm & pay page
@smoke
Scenario: Guest user buying book
  Given I choose to register
  When I complete registration successfully
  Then I should be on the Confirm & pay page
  When I enter valid New card details
  And I enter valid Billing address
  And click Confirm & pay button
  Then I should be on the Payment successful page







