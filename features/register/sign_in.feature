@register @ie @safari @CWA-143
Feature: Sign into Blinkbox books
  As a registered user of Blinkbox books
  I want to sign in
  So that I can access my account, read my library books and buy books

  Background: Navigate to sign in
    Given I am not signed in
    And I am on the Sign in page

  @sanity @production
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

  Scenario: Tick to show password after entering password
    Given I am on the Sign in page
    When I enter a password
    And I tick the checkbox show password while typing on the Sign in page
    Then the password should be visible on the Sign in page

  Scenario: Check password is hidden as you type
    Given I am on the Sign in page
    When I enter a password
    Then the password should not be visible on the Sign in page