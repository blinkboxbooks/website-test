Feature: As a returning user to blinkbox books, I want to be able to enter the voucher code, So I can add £5.00 credit to my account.

@wip @pending
Scenario: Returning user successfully redeems a voucher code
  Given I have signed in
  And I am on the Redeem page
  When I enter a new voucher code
  And I click to redeem it
  Then my account should be credited by £5

@manual @wip @pending
Scenario: Returning user trying to redeem a voucher code when not being critically elevated
  Given I have signed in
  And I am on the Redeem page
  But I am not critically elevated #due to this, the scenario cannot be automated.
  When I enter a new voucher code
  And I try to redeem it
  Then I am asked to sign in again
  When I reenter my credentials
  Then my account should be credited by £5

@manual @wip @pending
Scenario: Returning user trying to redeem a voucher code when not being critically elevated and signing in as a different user to the one already signed in
  Given I have signed in
  And I am on the Redeem page
  But I am not critically elevated #due to this, the scenario cannot be automated.
  When I enter a new voucher code
  And I try to redeem it
  Then I am asked to sign in again
  When I enter different credentials
  Then the new signed in account should be credited by £5

@wip @pending
Scenario: Returning user trying to redeem an already used voucher code by them
  Given I have signed in
  And I am on the Redeem page
  When I enter a voucher code that I have used before
  And I click to redeem it
  Then I should get an error message
  And my account should not be credited by £5

@wip @pending
Scenario: Returning user trying to redeem an already used voucher code by another account
  Given I have signed in
  And I am on the Redeem page
  When I enter a voucher code that has been used by another account
  Then I should get an error message
  And my account should not be credited by £5

@wip @pending
Scenario Outline: Returning user trying to redeem an invalid voucher code
  Given I have signed in
  And I am on the Redeem page
  When I enter an <invalid> voucher code
  And I try to redeem it
  Then I should get an error message
  And my account should not be credited by £5

  Examples:
  |invalid|Description   |
  |       |invalid length|
  |       |just numbers  |
  |       |just alphabets|
  |       |>19 characters|
  |       |with hyphens  |