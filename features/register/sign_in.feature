@register @ie @safari
Feature: Sign into Blinkbox books
  As a registered user of Blinkbox books
  I want to sign in
  So that I can access my account, read my library books and buy books

  Background: Navigate to sign in
    Given I am not signed in

  @smoke @production
  Scenario: Happy path user sign in
    Given I am on the Sign in page
    When I enter valid sign in details
    And I click sign in button
    Then I am successfully signed in
    And I am redirected to Home page

   @pending
  Scenario: Sign in by selecting Keep me signed in
    Given I am on the Sign in page
    When I enter valid sign in details
    And select Keep me signed in
    And I click sign in button
    Then I am successfully signed in
    And I am redirected to Home page


  @negative @production
  Scenario: Sign in with email address that is not registered
    Given I am on the Sign in page
    When I try to sign in with email address that is not registered
    Then sign in is not successful
    And "Your sign in details are incorrect. Please try typing them in again, or if you have forgotten your password, we’ll email you a reset link" message is displayed
    And link to reset password is displayed

  @negative @production
  Scenario: Sign in with incorrect password
    Given I am on the Sign in page
    When I try to sign in with incorrect password
    Then sign in is not successful
    And "Your sign in details are incorrect. Please try typing them in again, or if you have forgotten your password, we’ll email you a reset link" message is displayed
    And link to reset password is displayed

  @negative @production
  Scenario: Sign in with empty password
    Given I am on the Sign in page
    When I try to sign in with empty password field
    Then sign in is not successful
    And "Please enter your password" message is displayed

  @negative @production
  Scenario: Sign in incorrect email address
    Given I am on the Sign in page
    When I sign in with incorrect email address and password
    Then sign in is not successful
    And "Your sign in details are incorrect. Please try typing them in again, or if you have forgotten your  password, we’ll email you a reset link" message is displayed
    And link to reset password is displayed

  @production
  Scenario: Click send me a reset link
    Given I am on the Sign in page
    And I have attempted to sign in with incorrect password
    And link to reset password is displayed
    When I click on Send me a reset link
    Then reset password page is displayed

  @production
  Scenario:  Forgotten password link
    Given I am on the Sign in page
    When I click on Forgotton your password? link
    Then reset password page is displayed

  @production
  Scenario: Request Reset my password
    Given I am on the reset password page
    When I enter email address registered with blinkbox books
    And I click on Send reset link
    Then reset password response page is displayed
    And reset email confirmation message is displayed

  @negative @production
  Scenario: Enter invalid email address on reset my password screen
    Given I am on the reset password page
    When I enter incorrect email address
    And I click on send reset link button
    Then I should see reset error message
    And "It looks like there's something wrong with this email address. Please make sure you typed it correctly and try again" message is displayed



