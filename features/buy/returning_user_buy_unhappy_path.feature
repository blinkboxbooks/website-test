@buy
Feature:  Unhappy path buy
  As a blinkbox books user
  I should be shown relevant error messages when attempting to buy a book or add sample I already have in library.
  So that I can edit payment details or payment method.

  Background:
    Given I am not signed in
    And I am on the home page

  @negative
  Scenario Outline: Returning user attempting to buy a book that already exists in his library
    Given I have a <book_type> book in my library
    When I select above <book_type> book to buy
    And  sign in to proceed with purchase
    Then book already exists in the library message displayed in confirm and pay page

   Examples:
    |book_type|
    |pay for  |
    |free     |

  @negative
  Scenario Outline: Returning user attempting to a add book sample that already exists his in library
    Given  I have a <book_type> book sample in my library
    When I select above <book_type> book to add sample
    And sign in to proceed with adding sample
    Then sample already exists in the library message displayed in confirm and pay page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  @negative
  Scenario Outline: Returning user attempting to a add book sample of which full book already exists in his library
    Given  I have a <book_type> book in my library
    When I select above <book_type> book to add sample
    And  sign in to proceed with adding sample
    Then sample already exists in the library message displayed in confirm and pay page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  @negative
  Scenario Outline: Returning user buying a book, cvv not matching payment failure error from Braintree
    Given I have selected to buy a pay for book from Home page
    And sign in to proceed with purchase
    When I choose to pay with a new card
    And I submit payment details with not matching cvv <cvv_number>
    Then my payment is not successful
    And payment failure message should be displayed

  Examples:
    | cvv_number |
    | 201 |
    | 301 |
    | 200 |




