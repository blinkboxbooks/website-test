Feature: Manage personal details - change password
  As a singed in Blinkbox books user
  I need the ability to update my
  So I can keep my account up to date

  Background:
    Given I am on the home page

  @smoke
  Scenario: Successfully change password
    Given I have registered as new user without providing clubcard
    And I am on the Change your password section
    When I change password
    And I confirm changes
    Then Your personal details page is displayed
    And I can sign in with the new password successfully

  @negative
  Scenario: Change password by entering incorrect current password
    Given I have registered as new user without providing clubcard
    And I am on the Change your password section
    When I attempt to update password by providing incorrect current password
    Then "Current password provided is incorrect." message is displayed
    And my password is not updated

  @negative
  Scenario: Change password by providing not matching password
    Given I have registered as new user without providing clubcard
    And I am on the Change your password section
    When I attempt to update password by providing not matching passwords
    Then "Your password does not match." message is displayed
    And my password is not updated

  @negative
  Scenario: Change password with new password less than 6 characters
    Given I have registered as new user without providing clubcard
    And I am on the Change your password section
    When I attempt to update password by providing passwords less than 6 characters
    Then "Your new password is too short" message is displayed
    And my password is not updated