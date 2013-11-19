@buy
Feature: Returning buying book from Blinkbox Books
  As a Guest user of Blinkbox books
  I want to the ability to complete register and buy book in one flow
  So that I can read it
  Background:
    Given I have a stored card

  @smoke @regression @unstable
  Scenario: Returning logged in user buying book with saved payment card
    Given I have signed in
    When I have identified the book to buy
    When I pay with saved default card
    Then Order Complete page is displayed

  @smoke @regression
  @unstable
  Scenario: Returning user not logged in buying book with saved payment card
    Given I am not signed in
    When I have identified the book to buy
    And I sign in to proceed with purchase
    And I pay with saved default card
    Then Order Complete page is displayed

  @regression
  Scenario Outline: Returning logged in user buying book with new payment card and saving card details
    Given I have signed in
    And I have identified the book to buy
    When I choose to pay with a new card
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I confirm my payment details
    Then Order Complete page is displayed

  Examples: Card types
    | card_type        |
    | VISA             |
    | Mastercard       |
    | American Express |
    | VISA Debit       |

   @regression
   Scenario Outline: Returning user not logged in, buying book with new payment card  and saving card details
     Given I am not signed in
     And I have identified the book to buy
     And I sign in to proceed with purchase
     When I choose to pay with a new card
     And I enter valid <card_type> card details
     And I enter valid Billing address
     And I confirm my payment details
     Then Order Complete page is displayed

   Examples: Card types
     | card_type        |
     | VISA             |
     | Mastercard       |
     | American Express |
     | VISA Debit       |

  @regression
  Scenario Outline: Returning logged in user buying book with one off new payment card
    Given I have signed in
    And I have identified the book to buy
    When I choose to pay with a new card
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I choose not to save the payment details
    And I confirm my payment details
    Then Order Complete page is displayed

  Examples: Card types
    | card_type        |
    | VISA             |
    | Mastercard       |
    | American Express |
    | VISA Debit       |

  @regression
  Scenario Outline: Returning user not logged in, buying book with one off new payment card
    Given I am not signed in
    And I have identified the book to buy
    And I sign in to proceed with purchase
    When I choose to pay with a new card
    And I enter valid <card_type> card details
    And I enter valid Billing address
    And I choose not to save the payment details
    And I confirm my payment details
    Then Order Complete page is displayed

  Examples: Card types
    | card_type        |
    | VISA             |
    | Mastercard       |
    | American Express |
    | VISA Debit       |

  @regression
  Scenario: Returning user logged in buying a free book
    Given I have signed in
    And I have identified a free book to buy
    When I click Confirm order
    Then Order Complete page is displayed

  @regression
  Scenario: Returning user not logged in buying a free book
    Given I am not signed in
    And I have identified a free book to buy
    And I sign in to proceed with purchase
    When I click Confirm order
    Then Order Complete page is displayed
