Feature: Voucher code redemption

As a new or an existing logged out user of blinkbox books
I want to be able to add a voucher code in the registration/sign in flow
So I can get my account credited by £5.00.

  #These are the 1 line scenarios that are shown and discussed with the team and below is the expanded Gherkin
  #1. New user adding the voucher code during the registration flow - Happy path
  #2. Returning user adding the voucher code during the sign in flow - Happy path
  #3. New user adding the voucher code that has already been used during the registration flow - user is registered but we get an error at an intermediate stage
  #4. Returning user adding the voucher code that has already been used during the sign in flow - user is signed in but we get an error at an intermediate stage
  #5. New user adding the voucher code during the registration process but the registration is unsuccessful - user is not registered, no BE validation is done
  #6. Returning user adding the voucher code during the sign in process but the signing in is unsuccessful - user is not signed in, no BE validation is done

  Background:
    Given I am not signed in
    And I am on the redeem page

  @wip @pending @smoke
  Scenario: New user adding the voucher during the registration flow
    When I enter a valid voucher code
    And I click on Use this code
    Then the Registration form should be displayed
    When I fill the registration details
    And I click on Sign up
    Then I should be registered
    When I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  @wip @pending @smoke
  Scenario: Returning user adding the voucher during the sign in flow
    When I enter a valid voucher code
    And I click on Use this code
    Then the Registration form should be displayed
    But if I already have an account
    And I sign in
    Then I am successfully signed in
    When I confirm the voucher code redemption in stage two
    Then my account should be credited by £5


  #Negative Scenarios
  #------------------

  @wip @pending @negative
  Scenario: New user adding a voucher code that has already been used during the registration flow
    Given I enter a voucher code that has already been used
    And I click on Use this code
    Then the Registration form should be displayed
    When I fill the registration details
    And I click on Sign up
    Then I should be registered
    But I should see the error message that the voucher code has already been used

  @wip @pending @negative
  Scenario: Returning user adding a voucher code that has already been used during the sign in flow
    Given I enter a voucher code that has already been used
    And I click on Use this code
    Then the Registration form should be displayed
    But if I already have an account
    And I sign in
    Then I should be signed in successfullu
    But I should see the error message that the voucher code has already been used

  @wip @pending @negative
  Scenario: New user trying to add voucher code but gets an error during the registration process
    When I enter a valid voucher code
    And I click on Use this code
    Then the Registration form should be displayed
    When I fill the registration details
    But type passwords that are less than 6 characters
    And I click on Sign up
    Then the registration is not successful
    And "Your password is too short" message is displayed

  @wip @pending @negative
  Scenario: Returning user adding the voucher code but gets an error during the sign in process
    When I enter a valid voucher code
    And I click on Use this code
    And I try and sign in
    But I leave the password field empty
    Then "Please enter your password" message is displayed


