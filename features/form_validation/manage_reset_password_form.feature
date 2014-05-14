@pending @manual
Feature: Manage-reset password form validation
  In order to prevent user from resetting password with invalid values
  As a blinkbox books product owner
  I want the ability to validate change password form

  Scenario: Change password with empty enter password
    Given I am on the Change your password section
    When I change password
    But I leave the Enter password field empty
    Then "Please enter you new password" message is displayed
    And my password is not updated


  Scenario: Change password with empty re-enter password
    Given I am on the Change your password section
    When I change password
    But I leave the re-enter password field empty
    Then "Please re-enter your password" message is displayed
    And my password is not updated