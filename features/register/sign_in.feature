@register @ie @safari @CWA-143
Feature: Sign into Blinkbox books
  As a registered user of Blinkbox books
  I want to sign in
  So that I can access my account, read my library books and buy books

  Background: Navigate to sign in
    Given I am not signed in
    And I am on the Sign in page

  @smoke @production
  Scenario: Happy path user sign in
    When I enter valid sign in details
    And I click sign in button
    Then I am successfully signed in
    And I am redirected to Home page

  @production
  Scenario: Sign in by selecting Keep me signed in
    When I enter valid sign in details
    And select Keep me signed in
    And I click sign in button
    Then I am successfully signed in
    And I am redirected to Home page

  @negative @production
  Scenario Outline: Sign in with invalid email or password
    # Background steps are incompatible with Scenario Outline
    Given I am not signed in
    And I am on the Sign in page
    When I try to sign in with <invalid_credentials>
    Then sign in is not successful
    And the following error message is displayed:
    """
    Your sign in details are incorrect. Please try typing them in again, or if you have forgotten your password,
    we’ll email you a reset link
    """
    And link to reset password is displayed

  Examples:
    | invalid_credentials          |
    | not registered email address |
    | wrong password               |

  @negative @production
  Scenario Outline: Sign in with email address of invalid format
    When I try to sign in with email address of invalid format: <invalid_email>
    Then sign in is not successful
    And the following error message is displayed:
    """
    We could not recognise this email address. Please make sure you typed it correctly and try again
    """

  Examples:
    | invalid_email     |
    | no_dot@missingdot |

  @pending @CWA-143
  Examples: Bug? This message is displayed instead "Please enter the email address you used to sign up to blinkbox books"
    | invalid_email                  |
    | only_account_name              |
    | no_email_server_address@       |
    | no_domain@mail.                |
    | @no_account_name.com           |
    | @no_account_name_no_dot        |
    | £$%#@special.chars             |
    | special_chars@_£$%#_domain.com |

  @negative @production
  Scenario Outline: Sign in with empty email or password field
    When I try to sign in with empty <field_name> field
    Then sign in is not successful
    And "<message>" error message is displayed

  Examples:
    | field_name         | message                                                                                         |
    | email              | Please enter the email address you used to sign up to blinkbox books                            |
    | password           | Please enter your password                                                                      |
    | email and password | Please enter the email address you used to sign up to blinkbox books Please enter your password |

  Scenario: Tick to show password after entering password
    Given I am on the Sign in page
    When I enter a password
    And I tick the checkbox show password while typing on the Sign in page
    Then the password should be visible on the Sign in page

  Scenario: Check password is hidden as you type
    Given I am on the Sign in page
    When I enter a password
    Then the password should not be visible on the Sign in page