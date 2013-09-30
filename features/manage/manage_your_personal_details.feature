Feature: Update the Personal details of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to view my account page
  So I can view and update my personal details details
  #- Manage - Your personal details (8.3.0.0-L 1)

  Background:
    Given I am on the home page
    And I have signed in

  @CWA-213
  Scenario: Successfully update my personal details
    Given I am on the Your personal details page
    When I edit the first name and last name
    And I submit my personal details
    Then "Your personal details have been successfully updated" message is displayed
    When I go to Your personal details page
    Then the first name and last name are as submitted