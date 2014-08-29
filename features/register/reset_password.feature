Feature: Reset password with blinkbox books
  As a registered user of blinkbox books
  I want to reset my forgotten password
  So that I can sign into blinkbox books again

  Background: Navigate to sign in
    Given I am not signed in

  @production
  Scenario: Click send me a reset link
    Given I am on the Sign in page
    When I try to sign in with wrong password
    Then link to reset password is displayed
    When I click on Send me a reset link
    Then reset password page is displayed

  @production
  Scenario: Forgotten password link
    Given I am on the Sign in page
    When I click on Forgotten your password? link
    Then reset password page is displayed

  @production
  Scenario: Request Reset my password
    Given I am on the reset password page
    When I enter email address registered with blinkbox books
    And I click on Send reset link
    Then reset password response page is displayed
    And reset email confirmation message is displayed

  @production @negative
  Scenario: Enter invalid email address on reset my password screen
    Given I am on the reset password page
    When I enter incorrect email address
    And I click on send reset link button
    Then I should see reset error message
    And the following error message is displayed:
    """
    It looks like there's something wrong with this email address. Please make sure you typed it correctly and try again
    """