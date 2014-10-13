Feature: Voucher code redemption

As a returning user to blinkbox books
I want to be able to enter the voucher code
So I can add £5.00 credit to my account

  Background:
    Given I have signed in
    And I am on the Redeem page

  @wip @pending @smoke
  Scenario Outline: Returning user successfully redeems a voucher code
    Given I enter a <valid> voucher code
    When I click on Use this code
    And I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  Examples:
  |valid              |Description                    |
  |                   |Valid voucher without the space|
  |                   |Valid voucher with spaces      |



  #Negative Scenarios
  #------------------

  @wip @pending @negative
  Scenario Outline: Returning user trying to redeem an invalid voucher code
    And I am on the Redeem page
    When I enter an <invalid> voucher code
    And I click on Use this code
    Then "<error>" message is displayed

  Examples:
  |invalid              |Description                  |error|
  |11111111REDEEMED     |Already used                 |TBC  |
  |11111111111111111    |Invalid length >16 characters|TBC  |
  |5555555555555555     |Just numbers                 |TBC  |
  |aaaaBBBBccccDDDD     |Just alphabets               |TBC  |
  |!@£$%^&*ASDG3456     |Special characters           |TBC  |
  |123ABCDEFGHIBBBB     |Does not exist               |TBC  |
  |2222555566667777     |Expired                      |TBC  |
  |3333555566667777     |Disabled                     |TBC  |
  |9999555566667777     |Redemption limit exceeded    |TBC  |



  #Manual Scenarios
  #-----------------

  @manual @wip @pending
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage one
    Given I am not critically elevated
    When I enter a valid voucher code
    And I click on Use this code
    Then I am asked to sign in again
    When I reenter my credentials
    And I confirm the voucher code redemption in stage two
    Then my account should be credited by £5

  @manual @wip @pending
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated - stage two
    Given I am not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I reenter my credentials
    Then my account should be credited by £5

  @manual @wip @pending
  Scenario: Returning user trying to redeem a voucher code when not being critically elevated and signing in as a different user to the one already signed in
    Given I am not critically elevated
    When I confirm the voucher code redemption in stage two
    Then I am asked to sign in again
    When I enter different credentials
    Then the newly signed in account should be credited by £5

