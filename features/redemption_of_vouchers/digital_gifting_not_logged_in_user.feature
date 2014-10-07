Feature: As a new/returning logged out user to blinkbox books, I want to be able to add a voucher code in the registration/sign in flow, So I can get my account credited by £5.00.

@wip @pending
Scenario: New user adding the voucher during the registration flow
  Given as a new user I am on the Redeem page
  And I am not signed in
  Then I should see the registration form
  When I enter a new voucher code
  And fill the registration form
  And submit the details
  Then I should be registered
  When I confirm the voucher code redemption
  Then my account should be credited by £5


@wip @pending
Scenario: Returning user adding the voucher during the sign in flow
  Given as a returning user I am on the Redeem page
  And I am not signed in
  When I enter a new voucher code
  And I sign in
  And I confirm the voucher code redemption
  Then my account should be credited by £5

  #Negative Scenarios
  #------------------
@wip @pending @negative
 Scenario: New user trying to add voucher code gets an error during the registration process


@wip @pending @negative
 Scenario: Returning user adding the voucher code gets an error during the sign in process


