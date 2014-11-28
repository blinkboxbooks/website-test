@unstable
Feature: Voucher code redemption

  As an existing user
  I want to redeem a voucher code
  In order to get a gift credit to my account

  Background:
    Given I am signed in
    And I am on the Voucher Redemption page

  @smoke @manual
  Scenario Outline: Existing user redeems a valid voucher code
    When I submit a valid voucher code "<code>"
    And I confirm the voucher redemption
    Then the redemption confirmation message is displayed

  Examples:
    | code                   |
    | <a_valid_voucher_code> |
    #Please input a valid voucher code below before running the scenario
    #TODO: to make this scenario fully automated, we can make an API call to voucher generator service to get a new voucher code on a test environment

  @negative @production
  Scenario: Verify client validation for not allowing special characters
    When I submit a voucher code "123D!@£"
    Then "That code isn't quite right - it should be a combo of 16 letters and numbers." message is displayed

  @negative @production
  Scenario: Verify client validation on typing special characters
    When I start to enter a voucher code with special characters
    Then "Just letters and numbers please, e.g. A9K2" message is displayed

  @negative @production
  Scenario Outline: Verify client validation for the length of character entered
    When I submit an invalid voucher code "<invalid_code>"
    Then "<error_message>" message is displayed

  Examples:
    | invalid_code      | error_message                                                             |
    | 12D4567890        | That code's a bit short – it should be a combo of 16 letters and numbers. |
    | 11DB1111111111111 | That code's a bit long – it should be a combo of 16 letters and numbers.  |

  @negative
  Scenario Outline: Verify back-end error to retry the voucher again  #happy path cannot be automated as re-using the vouchers is not possible
    When I submit an invalid voucher code "<invalid_code>"
    Then "<error_message>" message is displayed

  Examples:
    | invalid_code     | error_message                                           |
    | CPBGFWUSDSFPG7HP | is past its use by date. Sorry, it's no longer valid.   |
    | 1234567890abcdef | doesn't exist! Keep an eye out for typos and try again. |


  #Manual Critical elevation scenarios
  #-----------------------------------

  @manual
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage one
    Given I am not critically elevated
    When I enter a valid voucher code
    And I click on Use this code
    Then I am asked to sign in again
    When I reenter my credentials
    And I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  @manual
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage two
    When I enter a valid voucher code
    And I click on Use this code
    And I become not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I reenter my credentials
    Then my account should be credited by £5

  @manual
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated and signing in as a different user to the one already signed in
    Given I am not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I enter different credentials
    Then the newly signed in account should be credited by £5

  @manual
  Scenario: User makes a mistake in the voucher code and corrects it
    When I submit an invalid voucher code
    Then error message is displayed
    And I submit a valid voucher code
    Then the redemption confirmation message is displayed

  @manual
  Scenario Outline: Voucher code has been used before user confirms the redemption
    When I submit a valid voucher code
    And my wife redeems the voucher on <account> account
    And I confirm the voucher redemption
    Then Already used error message id displayed

  Examples:
    | account     |
    | the same    |
    | a different |

