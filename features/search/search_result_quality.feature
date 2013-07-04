 @searchresults
Feature: Verify that search results match search criteria
  As a Blinkbox books user
  I want to see the search results matching my search criteria
  So that I can find what I am looking for

  Background: Open Blinkbox books home page
    Given I am on the home page

  Scenario: Exact match on author name
    When I search for "graham mort"
    Then search results should be displayed
     And the author name of first book displayed should contain "graham mort"


  Scenario: Exact match on title
    When I search for "fifty shades of grey"
    Then search results should be displayed
    And the title of first book displayed should contain "fifty shades of grey"


  Scenario: Exact match on ISBN
    When I search for "9780571267064"
    Then only one matching search result should be displayed
     And book name should be "Jack Maggs"
     And author name should be "Peter Carey"






