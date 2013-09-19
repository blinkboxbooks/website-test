Feature: Sign into Blinkbox books
  As a registered user of Blinkbox books
  I want to sign in
  So that I can access my account, read my library books and buy books

  Background: Navigate to sign in
    Given I am not signed in

  @smoke_test
   Scenario: Happy path user sign in
    Given I am on the Sign in page
    When I enter valid sign in details
    And I click sign in button
    Then I am successfully signed in
    And I am redirected to Home page

