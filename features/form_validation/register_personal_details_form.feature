@pending
Feature: Register page-personal details form validation
  In order to prevent user from registering with invalid values
  As a blinkbox books product owner
  I want the ability to validate personal details form

  Background:
    Given I am on the home page

  Scenario: Register with empty email address
    Given I am on the Register page
    When I fill the registration form without the email address field
    And I submit the registration form
    Then "Please enter your email address" message is displayed

  Scenario Outline: Register with malformed email address
    Given I am on the Register page
    When I fill the registration form with <malformed email address> as email address
    And I submit the registration form
    Then "Please enter your email address" message is displayed

  Examples:
    |malformed email address      |
    |plainaddress                 |
    |@%^%#$@#$@#.com              |
    |@example.com                 |
    |Joe Smith <email@example.com>|
    |email.example.com            |
    |email@example@example.com    |
    |.email@example.com           |
    |email.@example.com           |
    |email..email@example.com     |
    |email@example.com (Joe Smith)|
    |email@example                |
    |email@-example.com           |
    |email@example.web            |
    |email@111.222.333.44444      |
    |email@example..com           |
    |Abc..123@example.com         |

  Scenario: Register with empty first name
    Given I am on the Register page
    When I fill the registration form without the first name field
    And I submit the registration form
    Then "Please enter your first name" message is displayed


  Scenario: Register with empty last name
    Given I am on the Register page
    When I fill the registration form without the last name field
    And I submit the registration form
    Then "Please enter your last name" message is displayed

  Scenario Outline: Register with an invalid Clubcard number
    Given I am on the Register page
    When I fill the registration form with <invalid> clubcard number
    And I submit the registration form
    Then "This Tesco Clubcard number doesn't seem to be correct. Please check and try again" message is displayed

    Examples:
    |invalid             | more info                          |
    |634004023423697665  | Wrong clubcard number              |
    |63400402562369766500| Clubcard number with more digits   |
    |6340040256236976    | Clubcard number with less digits   |
    |abcdefghijklmop     | Letters in Clubcard number field   |

  Scenario: Register with empty password field
    Given I am on the Register page
    When I fill the registration form without the password field
    And I submit the registration form
    Then "Please enter your password" message is displayed

  Scenario: Register with empty re-enter password field
    Given I am on the registration form
    When I fill the registration form without the re-enter password field
    Then "Your passwords don't match, please check and try again" message is displayed

  Scenario: Register without checking Terms and conditions checkbox
    Given I am on the registration form
    When I fill the registration form
    But I do not tick the terms and conditions checkbox
    And I submit the registration form
    Then "Please accept the blinkbox books terms & conditions" message is displayed