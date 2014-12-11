@buy
Feature: Returning buying book from blinkbox books
  As a returning user of blinkbox books
  I want to the ability to sign in and buy a book
  So that I can read it

  Background:
    Given I have a stored card

  Scenario: Returning logged in user buying book with saved payment card
    Given I am buying a paid book as a logged in user
    When I pay with my saved default card
    Then my payment is successful

  @sanity
  Scenario: Returning user not logged in buying book with saved payment card
    Given I am buying a paid book as a not logged in user
    When I sign in to proceed
    Then the page title should be "confirm & pay"
    When I pay with my saved default card
    Then my payment is successful

  Scenario Outline: Returning logged in user buying book with new payment card and saving card details
    Given I am buying a paid book as a logged in user
    When I pay with a new <card_type> card
    And I choose to save the new payment details
    And I submit the payment details
    Then my payment is successful

  Examples: Card types
    | card_type  |
    | Mastercard |
    | VISA Debit |

  Scenario Outline: Returning user not logged in, buying book with one off new payment card
    Given I am buying a paid book as a not logged in user
    And I sign in to proceed
    When I pay with a new <card_type> card
    And I choose not to save the new payment details
    And I submit the payment details
    Then my payment is successful

  Examples: Card types
    | card_type  |
    | VISA       |
    | Mastercard |

  Scenario: Returning user logged in buying a free book
    Given I am buying a free book as a logged in user
    When I click on Confirm order
    Then my payment is successful

  Scenario: Returning user not logged in buying a free book
    Given I am buying a free book as a not logged in user
    And I sign in to proceed with the purchase
    When I click on Confirm order
    Then my payment is successful

  @sanity @production
  Scenario: Returning user buying a free book from grid view
    Given I have selected to buy a free book from Grid view
    And I sign in to proceed with the purchase
    When I click on Confirm order
    Then my payment is successful

  @CWA-1000
  Scenario: Returning user adding a book sample to library first and then buying the book.
    Given PENDING: CWA-1000 ?????
    Given I have identified a paid book on the book details page to read sample offline
    When I select Read offline on the book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful
    When I select the above book to buy
    And I submit the payment details
    Then my payment is successful
