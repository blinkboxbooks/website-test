@buy
Feature: Returning buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it
  Background:
    Given I have a stored card

  @smoke
  Scenario: Returning logged in user buying book with saved payment card
    Given I have signed in
    When I have identified the book to buy
    When I pay with saved default card
    Then Order Complete page is displayed

  @smoke
  Scenario: Returning user not logged in buying book with saved payment card
    Given I am not signed in
    When I have identified the book to buy
    And I sign in to proceed with purchase
    And I pay with saved default card
    Then Order Complete page is displayed


  Scenario Outline: Returning logged in user buying book with new payment card and saving card details
    Given I am buying a pay for book as a logged in user
    When I pay with a new <card_type> card
    And I choose to save new payment details
    And I submit payment details
    Then my payment is successful

  Examples: Card types
    | card_type        |
    | VISA             |
    | Mastercard       |
    | American Express |
    | VISA Debit       |

  Scenario Outline: Returning user not logged in, buying book with one off new payment card
    Given I am buying a pay for book as a not logged in user
    And I sign in to proceed with purchase
    When I pay with a new <card_type> card
    And I choose not to save new payment details
    And I submit payment details
    Then my payment is successful

  Examples: Card types
    | card_type  |
    | Mastercard |

  Scenario: Returning user logged in buying a free book
    Given I am buying a free book as a logged in user
    When I click Confirm order
    Then Order Complete page is displayed

  @regression
  Scenario: Returning user not logged in buying a free book
    Given I am buying a free book as a not logged in user
    And I sign in to proceed with purchase
    When I click Confirm order
    Then Order Complete page is displayed
