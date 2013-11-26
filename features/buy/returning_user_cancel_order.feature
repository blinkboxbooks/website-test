@buy @wip
Feature: Returning buying book from blinkbox books
  As a returning user of blinkbox books
  I want to the ability to cancel order
  So that I can cancel unwanted order.

  Background:
    Given I have a stored card

  Scenario: Returning user buying same book twice
    Given I am buying a pay for book as a logged in user
    And I pay with saved default card
    When I try to buy above book again
    Then payments page displayed with you already have this book message

  Scenario: Returning user cancels order when paying with saved cards
    Given I am buying a pay for book as a logged in user
    And my default card is selected for payment
    When I Cancel order
    And confirm cancel
    Then I am redirected to Home page

  Scenario: Returning user cancels orders when paying with new payment
    Given I am buying a pay for book as a logged in user
    And I choose to pay with a new card
    When I cancel order
    And confirm cancel
    Then I am redirected to Home page

  Scenario: Returning user cancels orders when paying with new payment and have failed payment
    Given I am buying a pay for book as a logged in user
    And I choose to pay with a new card
    And I have payment failures on the page
    When I cancel order
    And confirm cancel
    Then I am redirected to Home page

  Scenario: Returning user cancels orders when paying with new payment and have validation errors on the page
    Given I am buying a pay for book as a logged in user
    And I choose to pay with a new card
    And I have validation error messages on the page
    When I cancel order
    And confirm cancel
    Then I am redirected to Home page
