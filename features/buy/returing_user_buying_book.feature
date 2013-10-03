Feature: Returning buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it
  Background:
    Given I have a stored card

  @smoke
  Scenario: Returning logged in user buying book
    Given I have signed in
    When I have identified the book to buy
    When I pay with saved default card
    Then I should be on the Payment successful page

  @smoke
  Scenario: Returning user not logged in buying book
    Given I am not signed in
    When I have identified the book to buy
    And I sign in successfully to proceed with purchase
    And I pay with saved default card
    Then I should be on the Payment successful page

