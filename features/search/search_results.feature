@wip @searchresults
Feature: Verify that search results match search criteria
  As a Blinkbox books user
  I want to see the search results matching my search criteria
  So that I can find what I am looking for

  Background: Open Blinkbox books home page
    Given I am on the home page


   Scenario: exact match on author name
     When I search with full author name
     Then results should be displayed
      And the first result should contain author name


   Scenario: exact match on title
     When I search with full title name
     Then results should be displayed
      And the first result should contain title


  Scenario: exact match on ISBN
    When I search with full ISBN
    Then One result matching ISBN should be displayed






