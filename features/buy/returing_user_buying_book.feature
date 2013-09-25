Feature: Returning buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it

  Background:

  @smoke_test
  Scenario: Returning logged in user buying book
    Given I have signed in
    When I have identified the book to buy
    Then I should be on the Confirm & pay page
    When I choose to pay with saved card
    And click Confirm & pay button
    Then I should be on the Payment successful page


  @smoke_test
  Scenario: Returning user not logged in buying book
    Given I am not signed in
    And I have identified the book to buy
    When I sign in successfully
    Then I should be on the Confirm & pay page
    When I choose to pay with saved card
    And click Confirm & pay button
    Then I should be on the Payment successful page

