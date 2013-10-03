Feature: Returning buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it
  Background:
    Given I have stored cards

  @smoke
  Scenario: Returning logged in user buying book
    Given I have signed in
    When I have identified the book to buy
    Then I should be on the Confirm & pay page
    When I choose to pay with saved default card
    Then I should be on the Payment successful page

  @smoke
  Scenario: Returning user not logged in buying book
    Given I am not signed in
    Given I have identified the book to buy
    When I sign in successfully
    Then I should be on the Confirm & pay page
    When I choose to pay with saved default card
    Then I should be on the Payment successful page

