@searchresults
Feature: Verify that search results match search criteria
  As a Blinkbox books user
  I want to see the search results matching my search criteria
  So that I can find what I am looking for

  Background: Open Blinkbox books home page
    Given I am on the home page

  @smoke @data-dependent @production
   Scenario: Search results displayed
    When I search for "spring"
    Then Search Results page is displayed
    And at least 1 search result is shown

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

  @CWA-88 @wip
  Scenario: Editing search url should update search results
    When I search for "alice"
    Then page url should have "alice"
    And search results should be displayed
    And I change search term in url to "wonder"
    Then page url should have "wonder"
    And search results should be displayed

  @CWA-88
  Scenario: Copy and paste search url to another browser session
    When I search for "dan"
    Then page url should have "dan"
    And search results should be displayed
    And copy paste url into another browser session
    Then page url should have "dan"
    And search results should be displayed




