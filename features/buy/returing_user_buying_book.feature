@buy
Feature: Returning buying book from blinkbox books
  As a returning user of blinkbox books
  I want to the ability to sign in and buy a book
  So that I can read it

  Background:
    Given I have a stored card

  @smoke
  Scenario: Returning logged in user buying book with saved payment card
    Given I am buying a pay for book as a logged in user
    When I pay with saved default card
    Then my payment is successful

  @smoke
  Scenario: Returning user not logged in buying book with saved payment card
    Given I am buying a pay for book as a not logged in user
    When I sign in to proceed with purchase
    And I pay with saved default card
    Then my payment is successful

  Scenario Outline: Returning logged in user buying book with new payment card and saving card details
    Given I am buying a pay for book as a logged in user
    When I pay with a new <card_type> card
    And I choose to save new payment details
    And I submit payment details
    Then my payment is successful

  Examples: Card types
    | card_type        |
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
    | VISA       |
    | Mastercard |

  Scenario: Returning user logged in buying a free book
    Given I am buying a free book as a logged in user
    When I click Confirm order
    Then my payment is successful

  Scenario: Returning user not logged in buying a free book
    Given I am buying a free book as a not logged in user
    And I sign in to proceed with adding sample
    When I click Confirm order
    Then my payment is successful

  @wip
  Scenario Outline: Returning user adding a sample to library
    Given I have identified a <book_type> book to read sample offline
    When I select Read offline in book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful

  Examples:
    | book_type |
    | pay for   |
    | free      |

  @wip
   Scenario: Returning user adding a book sample to library first and then buying the book.
    Given I have identified a pay for book to read sample offline
    When I select Read offline in book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful
    When I select the above book to buy
    And I click Confirm order
    Then my payment is successful

  @manual
  Scenario: Returning user buying a book with credit
    Given I have account credit
    When I click Buy now on a pay for book as a logged in user
    And I click Confirm order
    Then my payment is successful
