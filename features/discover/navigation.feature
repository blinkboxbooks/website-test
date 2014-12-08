@navigation @ie @safari
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @smoke @production
  Scenario: Navigate to book details page
    When I select a book to view book details
    Then details page of the corresponding book is displayed
    And details of above book are displayed

  @smoke @production
  Scenario: Navigate to a Category page
    Given I am on Categories page
    When I click on a category
    Then Category page is displayed for the selected category

  @smoke @production
  Scenario: Read a sample
    Given I am on the Book Details page of a paid book
    And  the book reader is displayed
    And I am able to read the sample of corresponding book

  @production
  Scenario: Clicking browser back should load previous search results pages if any
    When I search for following words
      | words     |
      | da vinci  |
      | dan brown |
    And I press browser back
    And I should see search results page for "da vinci"

  @CWA-70 @production
  Scenario: Main header tabs are not selected in search results
    When I search for "summer"
    Then search results should be displayed
    And main header tabs should not be selected

  @production
  Scenario Outline: Search word should not visible upon user navigating to another page
    When I search for "dan brown"
    Then "dan brown" should be visible in search bar
    And I click on the <page> header tab
    Then search term should not be visible in search bar

  Examples:
    | page         |
    | Featured     |
    | Categories   |
    | Bestsellers  |
    | New releases |
    | Free eBooks  |
    | Authors      |

  Scenario: Promotable category - Daily bestsellers
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I should see Promotions section header as Daily bestsellers
    And I should see 5 books being displayed

  @production
  Scenario: Bestsellers page - Switching views
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select grid view
    Then I should see Fiction books in grid view
    And I select list view
    Then I should see Fiction books in list view

  @CWA-71 @production
  Scenario: Bestsellers page - Grid view not changing between tabs
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select grid view
    Then I should see Fiction books in grid view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in grid view

  @CWA-71 @production
  Scenario: Bestsellers page - List view not changing between tabs
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select list view
    Then I should see Fiction books in list view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in list view

  @CWA-34 @manual
  Scenario:Book Component-List view Title display
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And  I select list view
    Then long titles should be displayed in two lines

  @CWA-34  @manual
  Scenario:Book Component-Grid view Title display
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And  I select grid view
    Then long titles should be truncated to fit within image