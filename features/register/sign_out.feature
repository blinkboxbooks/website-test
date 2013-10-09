Feature: Sign out from Blinkbox books
  As a signed in user
  I want to sign out from Blinkbox books
  So that I can prevent unauthorised access to my account

  Background:
    Given I am on the home page
    And I have signed in

  @smoke
  Scenario: Sign out from home page
    When I select Sign out link from drop down menu
    Then I should be signed out successfully
    And I am redirected to Home page

  Scenario Outline: : Sign out from blinkbox books
    Given I am on the <my_account> tab
    When I click Sign out button
    Then I should be signed out successfully
    And I am redirected to Home page

  @smoke
  Examples: smoke
    | my_account              |
    | Order & payment history |

  @CWA-184
  Examples: Other sign out scenarios
    | my_account            |
    | Your personal details |
    | Your payments         |
    | Your devices          |
