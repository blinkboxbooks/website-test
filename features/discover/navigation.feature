@navigation @ie @safari @production
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  @sanity
  Scenario: Navigate to book details page
    Given I am on the home page
    When I select a book to view book details
    Then details page of the corresponding book is displayed
    And details of above book are displayed

  @sanity
  Scenario: Navigate to a Category page
    Given I am on Categories page
    When I click on a category
    Then Category page is displayed for the selected category

  @sanity
  Scenario: Read a sample
    Given I am on the Book Details page of a paid book
    And  the book reader is displayed
    And I am able to read the sample of corresponding book

  Scenario: Clicking browser back should load previous search results pages if any
    Given I am on the home page
    When I search for following words
      | words     |
      | da vinci  |
      | dan brown |
    And I press browser back
    And I should see search results page for "da vinci"

  Scenario: Search word should not visible upon user navigating to another page
    Given I am on the home page
    When I search for "dan brown"
    Then "dan brown" should be visible in search bar
    And I click on the Categories header tab
    Then search term should not be visible in search bar

  Scenario: Promotable category - Daily bestsellers
    Given I am on the Bestsellers page
    And I should see Promotions section header as Daily bestsellers
    And I should see 5 books being displayed

  Scenario Outline: Bestsellers page - View not changing between tabs
    Given I am on the Bestsellers page
    When I select <view> view
    Then I should see Fiction books in <view> view
    When I click on Non-Fiction tab
    Then I should see Non-Fiction books in <view> view

    Examples:
      | view |
      | grid |
      | list |
