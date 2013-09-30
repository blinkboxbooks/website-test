@manual
Feature:

IN ORDER TO know my password is safe AS A registering user I WANT TO see a password strength indicator


  Background:
    Given I am on the home page

  Scenario: Password not entered
    Given I am not signed in
    And I am on the registrations page
    When password length = 0 characters
    Then show text "password strength" in the password strength indicator
    And set colour of password strength indicator to grey

  Scenario: Less than six characters for password
    Given I am not signed in
    And I am on the registrations page
    When I type less than six characters for password
    Then I see "Your password should be at least 6 characters" message
    And password strength indicator colour is grey

  Scenario Outline: Valid password strength indicator
    Given I am not signed in
    And I am on the registrations page
    When I type <password> for password
    Then I see "<strength_text>" message
    And password strength indicator colour is <strength_colour>
  Examples:
  |password               |strength_text |strength_colour|
  |123456                 | Very weak    | Grey          |
  | sixsix                | Very weak    | Red           |
  | Abc123                | Very weak    | Red           |
  | Abcd987               | Weak         | Red           |
  | AbCdEf456             | Weak         | Red           |
  | !?bCdEf123            | Medium       | Orange        |
  | >Pa55w0RD!?-          | Medium       | Orange        |
  | >Pa55w0RD!?-(j}       | Medium       | Orange        |
  | >Pa55w0RD!?-(zz}      | Strong       | Green         |
  | >Pa55=/w0RD!?+$:{)*12 | Very strong  | Green         |

  #change password page

  Scenario: Password not entered
    Given I have signed in
    And I am on the change password page
    When password length = 0 characters
    Then show text "password strength" in the password strength indicator
    And set colour of password strength indicator to grey

  Scenario: Less than six characters for password
    Given I have signed in
    And I am on the change password page
    When I type less than six characters for password
    Then I see "Your password should be at least 6 characters" message
    And password strength indicator colour is grey

  Scenario Outline: Valid password strength indicator
    Given I have signed in
    And I am on the change password page
    When I type <password> for password
    Then I see "<strength_text>" message
    And password strength indicator colour is <strength_colour>
  Examples:
    |password               |strength_text |strength_colour|
    |123456                 | Very weak    | Grey          |
    | sixsix                | Very weak    | Red           |
    | Abc123                | Very weak    | Red           |
    | Abcd987               | Weak         | Red           |
    | AbCdEf456             | Weak         | Red           |
    | !?bCdEf123            | Medium       | Orange        |
    | >Pa55w0RD!?-          | Medium       | Orange        |
    | >Pa55w0RD!?-(j}       | Medium       | Orange        |
    | >Pa55w0RD!?-(zz}      | Strong       | Green         |
    | >Pa55=/w0RD!?+$:{)*12 | Very strong  | Green         |


  #reset password page from forgot password email link.