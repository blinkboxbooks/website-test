@manual
Feature: Manual test scenarios for buy flow
@CWA-226
  Scenario Outline: Identifying the type of card being used
    Given I am on the Confirm and pay page
    And I am paying with a new card
    When I start entering card number with <digits>
    Then card type icon <card__type_icon> is illuminated
  Examples:
  |digits |card__type_icon        |
  |4      |VISA             |
  |51     |MasterCard       |
  |52     |MasterCard       |
  |53     |MasterCard       |
  |54     |MasterCard       |
  |55     |MasterCard       |
  |34     |American Express |
  |37     |American Express |
  @CWA-226
  Scenario Outline: Not identifying the type of the card being used
    Given I am on the Confirm and pay page
    And I am paying with a new card
    When I enter first <digits> of card number that are not valid
    Then card type icons are not illuminated
  Examples:
    | digits           |
    | 3                |
    | 50               |
    | 56               |
    | 53               |
    | 35               |
    | 33               |
    | 38               |
    | 36               |
    | VISA             |
    | MasterCard       |
    | American Express |

  @CWA-226
  Scenario Outline: card number validation
    Examples:
  |Card number |digits 0-9 |
  @CWA-226
  Scenario Outline:: Expiry date validation
  Examples:
    |greater than current month and year combination|
  @CWA-226
  Scenario Outline:: CVV validation
  Examples:
    |Card security no. (CVV) |3 digits for VISA, MASTERCARD & 4 digits for AMEX|
  @CWA-226
  Scenario Outline:: Name on card validation
  Examples:
    |Name on card | anything as long at it's not just 0-9 digits |
  @CWA-226
  Scenario Outline:: Address line1 validation
  Examples:
    |Address line 1 | anything as long at it's not just 0-9 digits |
  @CWA-226
  Scenario Outline: Town or city validation
    Examples:
    |Town or city | Alpha numeric |
  @CWA-226
  Scenario Outline: Post code validation
    Examples:
  |Postcode | Alpha numeric |
  @CWA-226
  Scenario Outline: Address line 2 validation
   Examples: | Address line 2 | anything as long at it's not just 0-9 digits |
  @CWA-226
  Scenario: Submit with empty form
