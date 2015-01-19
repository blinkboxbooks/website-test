@buy
Feature: Unhappy path buy
  As a blinkbox books user
  I should be shown relevant error messages when attempting to buy a book or add sample I already have in library.
  So that I can edit payment details or payment method.

  @negative @ie @safari
  Scenario Outline: Existing user attempting to buy a book that already exists in his library
    Given I have purchased a <book_type> book
    When I am on the Book Details page for the same <book_type> book
    And I try to buy the book again
    Then "You already have this book in your library" message is displayed

   Examples:
    | book_type |
    | paid      |
    | free      |

  @negative
  Scenario Outline: Existing user buying a book, cvv not matching payment failure error from Braintree
    Given I am on the Confirm and pay page trying to buy a paid book
    When I choose to pay with a new card
    And I submit the payment details with not matching cvv <cvv_number>
    Then my payment is not successful
    And payment failure message should be displayed

  Examples:
    | cvv_number |
    | 201        |
    | 301        |
    | 200        |




