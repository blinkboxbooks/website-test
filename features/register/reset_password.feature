Feature: Reset password with blinkbox books
  As a registered user of blinkbox books
  I want to reset my forgotten password
  So that I can sign into blinkbox books again

  Background: Navigate to sign in
    Given I am not signed in

  
  Scenario: Click send me a reset link
    Given I am on the Sign in page
    When I try to sign in with wrong password
    Then link to reset password is displayed
    When I click on Send me a reset link
    Then reset password page is displayed

  
  Scenario: Forgotten password link
    Given I am on the Sign in page
    When I click on Forgotten your password? link
    Then reset password page is displayed

   @CP-314
  Scenario: Password reset with valid email
    Given I am on the reset password page
    When I enter email address registered with blinkbox books
    And I click on Send reset link
    Then reset password response page is displayed
    And reset email confirmation message is displayed

   @CP-314
  Scenario: Password reset with invalid email - app should not expose registered email addresses
    Given I am on the reset password page
    When I enter email address not registered with blinkbox books
    And I click on Send reset link
    Then reset password response page is displayed
    And reset email confirmation message is displayed

  @negative 
  Scenario Outline: Enter invalid email address on reset my password screen
    Given I am on the reset password page
    When I enter email address of invalid format: <invalid_email>
    And I click on send reset link button
    Then I should see reset error message
    And the following error message is displayed:
    """
    It looks like there's something wrong with this email address. Please make sure you typed it correctly and try again
    """

  Examples:
    | invalid_email                  |
    | no_dot@missingdot              |
    | only_account_name              |
    | no_email_server_address@       |
    | no_domain@mail.                |
    | @no_account_name.com           |
    | @no_account_name_no_dot        |
    | £$%#_@special.chars            |
    | special_chars@_£$%#_domain.com |

  @negative 
  Scenario: Leave blank email address on reset my password screen
    Given I am on the reset password page
    When I enter blank email address
    And I click on send reset link button
    Then I should see reset error message
    And the following error message is displayed:
    """
    Please enter the email address you used to sign up to blinkbox books
    """