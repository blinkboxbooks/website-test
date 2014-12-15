@buy
Feature: Returning buying book from blinkbox books
  As a returning user of blinkbox books
  I want to the ability to sign in and buy a book
  So that I can read it

  Background:
    Given I have a stored card

  Scenario: Existing user buys a book with saved payment card
    Given I am buying a paid book as a logged in user
    When I pay with my saved default card
    Then my payment is successful

  @sanity
  Scenario: Existing user buys a book with saved payment card and signs in during the purchase flow
    Given I am buying a paid book as a not logged in user
    When I sign in to proceed with the purchase
    Then the page title should be "confirm & pay"3
    When I pay with my saved default card
    Then my payment is successful

  Scenario Outline: Existing user buys a book with a new payment card and saves card details
    Given I am buying a paid book as a logged in user
    When I pay with a new <card_type> card
    And I choose to save the new payment details
    And I submit the payment details
    Then my payment is successful

  Examples: Card types
    | card_type  |
    | Mastercard |
    | VISA Debit |

  Scenario Outline: Existing user buys a book with one off new payment card and signs in during the purchase flow
    Given I am buying a paid book as a not logged in user
    And I sign in to proceed with the purchase
    When I pay with a new <card_type> card
    And I choose not to save the new payment details
    And I submit the payment details
    Then my payment is successful

  Examples: Card types
    | card_type  |
    | VISA       |
    | Mastercard |

  @sanity
  Scenario: Existing user signs in and buys a free book
    Given I am buying a free book as a logged in user
    When I click on Confirm order
    Then my payment is successful

  Scenario: Existing user buys a free book and signs in during the purchase flow
    Given I am buying a free book as a not logged in user
    And I sign in to proceed with the purchase
    When I click on Confirm order
    Then my payment is successful

  Scenario: Existing user buys a free book from Grid view and signs in during the purchase flow
    Given I have selected to buy a free book from Grid view
    And I sign in to proceed with the purchase
    When I click on Confirm order
    Then my payment is successful

  @CWA-1000
  Scenario: Existing user tries to buy a book, for which he already has sample in the library
    Given PENDING: CWA-1000 ?????
    Given I have identified a paid book on the book details page to read sample offline
    When I select Read offline on the book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful
    When I select the above book to buy
    And I submit the payment details
    Then my payment is successful
