Feature: Navigating through my account pages
  As a singed in Blinkbox books user
  I need the ability to view my account page
  So that I can view and update my account details

  Background:
    Given I am on the home page

  @smoke
  Scenario: Navigate to Order & Payment history
    Given I have signed in
    When I select Order & payment history link from drop down menu
    Then Your order & payment history page is displayed
    And Order & payment history tab is selected

  @smoke
  Scenario: Navigate to Your personal details
    Given I have signed in
    When I select Your personal details link from drop down menu
    Then Your personal details page is displayed
    And Your personal details tab is selected

  @smoke
  Scenario: Navigate to Your payments
    Given I have signed in
    When I select Your payments link from drop down menu
    Then Your payments page is displayed
    And Your payments tab is selected

  @smoke
  Scenario: Navigate to Your devices
    Given I have signed in
    When I select Your devices link from drop down menu
    Then Your devices page is displayed
    And Your devices tab is selected




