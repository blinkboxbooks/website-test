@manual
Feature: Critical elevation for voucher redemption

  Being a logged in user
  I have to re-verify my identity if my session is not longer critically elevated
  In order to get a gift credit to my account

  Background:
    Given I am signed in
    And I am on the Voucher Redemption page

  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage one
    Given I am not critically elevated
    When I enter a valid voucher code
    And I click on Use this code
    Then I am asked to sign in again
    When I reenter my credentials
    And I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage two
    When I enter a valid voucher code
    And I click on Use this code
    And I become not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I reenter my credentials
    Then my account should be credited by £5

  Scenario: Returning user trying to redeem a voucher code when not being critically elevated and signing in as a different user to the one already signed in
    Given I am not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I enter different credentials
    Then the newly signed in account should be credited by £5