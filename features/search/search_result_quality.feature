@searchresults @ie @safari
Feature: Verify that search results match search criteria
  As a Blinkbox books user
  I want to see relevant results for my search
  So that I can quickly find the book I want

  Background: Open Blinkbox books home page
    Given I am on the home page

  @CWA-866
  Scenario Outline: Search for a word that does not return any results
    When I search for "<invalid_search_item>"
    Then no result message is displayed
    And the options of switching view mode should not appear
    And the matching books message is not displayed

  Examples:
    | invalid_search_item |
    | blahblahblahblah    |
    | $%^$%&^%*^&         |

  @data-dependent @sanity @production
  Scenario: Search results displayed
    When I search for "history"
    Then Search Results page is displayed
    And at least 1 search result is shown
    And the matching books message shows at least 1 book

  @CWA-866 @pending
  Scenario: Suggested word for misspelled search words

  @CWA-88
  Scenario: Editing search url should update search results
    When I search for "Alice"
    Then page url should have "Alice"
    And search results for "Alice" should be displayed
    When I change search term in url to "wonder"
    Then page url should have "wonder"
    And search results for "wonder" should be displayed

 @manual @CWA-88
  Scenario: Copy and paste search url to another browser session
    When I search for "dan"
    Then page url should have "dan"
    And search results should be displayed
    And copy paste url into another browser session
    Then page url should have "dan"
    And search results should be displayed

  @manual @data-dependent
  Scenario: Exact match on author name
    When I search for "graham mort"
    Then search results should be displayed
    And the author name of first book displayed should contain "graham mort"

  @manual @data-dependent
  Scenario: Exact match on title
    When I search for "fifty shades of grey"
    Then search results should be displayed
    And the title of first book displayed should contain "fifty shades of grey"

  @manual @data-dependent
  Scenario: Exact match on ISBN
    When I search for "9780571267064"
    Then only one matching search result should be displayed
    And book name should be "Jack Maggs"
    And author name should be "Peter Carey"

  Scenario: Click on next button on search result page
    Given I search for "Gone girl"
    Then Search Results page is displayed
    When I click on next button on pagination
    Then then the selected page number should be "2"

  Scenario: Click on previous button on search result page
    Given I search for "gone girl"
    Then Search Results page is displayed
    When I click on page number "5"
    And I click on previous button on pagination
    Then then the selected page number should be "4"

  Scenario: Click on page number and verify URL
    Given I search for "gone girl"
    Then Search Results page is displayed
    When I click on page number "7"
    Then page number url should have "7"

  @manual
  Scenario Outline: Enter invalid page number in the url
    Given I search for "gone girl"
    Then Search Results page is displayed
    When I edit the page url to <a_non_existing_one>
    Then it redirects back to <correct_page_number>

  Examples:
    | a_non_existing_one | correct_page_number |
    | 500000             | 178                 |
    | -1                 | 1                   |
    | 0.0                | 1                   |

    Scenario: Verify the pagination appears correctly for Grid and List view
      Given I search for "gone girl"
      Then Search Results page is displayed
      And pagination should be displayed in grid view
      Then I change from Grid mode to List mode
      And pagination should be displayed in list view


