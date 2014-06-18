#Once QA is back, re-run all the scenarios to check they are passing as part of TTWG-65 and remove this comment.
@buy 
Feature: Returning buying book from blinkbox books
  As a returning user of blinkbox books
  I want to the ability to sign in and buy a book
  So that I can read it

  Background:
    Given I have a stored card

  @smoke
  Scenario: Returning logged in user buying book with saved payment card
    Given I am buying a paid book as a logged in user
    When I pay with saved default card
    Then my payment is successful

  @smoke
  Scenario: Returning user not logged in buying book with saved payment card
    Given I am buying a paid book as a not logged in user
    When I sign in to proceed with purchase
    Then title should be "confirm & pay"
    And I pay with saved default card
    Then my payment is successful

  Scenario Outline: Returning logged in user buying book with new payment card and saving card details
    Given I am buying a paid book as a logged in user
    When I pay with a new <card_type> card
    And I choose to save new payment details
    And I submit payment details
    Then my payment is successful

  Examples: Card types
    | card_type        |
    | Mastercard       |
    | VISA Debit       |

  Scenario Outline: Returning user not logged in, buying book with one off new payment card
    Given I am buying a paid book as a not logged in user
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
    And I sign in to proceed with purchase
    When I click Confirm order
    Then my payment is successful

    Scenario: Returning user buy a book from grid view
      Given I am buying a free book as a logged in user
      When I select buy now from the gird view
      And I click Confirm order
      Then my payment is successful

   @CWA-1000
   Scenario: Returning user adding a book sample to library first and then buying the book.
    Given PENDING: CWA-1000 ?????
    Given I have identified a paid book to read sample offline
    When I select Read offline on the book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful
    When I select the above book to buy
    And I submit payment details
    Then my payment is successful
