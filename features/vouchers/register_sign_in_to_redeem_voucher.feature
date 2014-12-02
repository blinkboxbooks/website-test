Feature: Registration / sign in during gift voucher redemption

  As a guest user trying to redeem a voucher
  I have to register or sign in
  In order to get a gift credit to my account

  Background:
    Given I am not signed in
    And I am on the Voucher Redemption page

  @smoke @pending
  Scenario: User registers a new account during voucher redemption
    When I submit a valid voucher code <code>
    Then the Registration form should be displayed
    When I submit the registration details
    Then I should be registered
    When I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  @smoke @pending
  Scenario: User signs in during voucher redemption
    When I enter a valid voucher code
    And I click on Use this code
    Then the Registration form should be displayed
    When I choose to sign in
    And I enter details to sign in
    Then I am successfully signed in
    When I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  @negative
  Scenario: User registers a new account while trying to redeem an already used voucher code
    When I submit an already used voucher code
    And I submit the registration details
    Then voucher validation error is displayed
    But I should be signed in now

  @negative
  Scenario: User signs while trying to redeem an already used voucher code
    When I submit an already used voucher code
    And I choose to sign in
    And I sign in with an exiting account
    Then voucher validation error is displayed
    But I should be signed in now

  @negative @production
  Scenario: User tries to register a new account with incomplete details during voucher redemption
    Given I submit an already used voucher code
    Then the Registration form should be displayed
    When I submit the registration details with password less than 6 characters
    Then the registration is not successful

  @negative @production
  Scenario: User tries to sign in with incomplete details during voucher redemption
    Given I submit an already used voucher code
    When I choose to sign in
    And I try and sign in without a password
    Then the sign in is not successful


