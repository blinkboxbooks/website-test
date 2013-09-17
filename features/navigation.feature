@smoke
@navigation
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @smoke
  Scenario: Clicking on the website logo
    When I click on the website logo
    Then I should return to the home page

# Scenario: Navigating with the categories link
#	Given the categories link is present in the header
#	Then the link should point to the categories page

  Scenario: Navigating to the help site from the footer
    Given the blinkbox books help link is present in the footer
    Then the link should point to the blinkbox books help home page

  Scenario: Navigating to the blinkbox movies site from the footer
    Given the blinkbox movies link is present in the footer
    Then the link should point to the blinkbox movies home page

  Scenario: Navigating to the blinkbox music site from the footer
    Given the blinkbox music link is present in the footer
    Then the link should point to the blinkbox music home page

  @desktop @mobile

  Scenario: Navigating with the categories link
    When I click on the Categories link
    Then I should be on the Categories page

  @CWA-87
  Scenario: Clicking browser back should load previous search results pages if any
    When I search for following words
      | words     |
      | da vinci  |
      | dan brown |
    And I press browser back
    And I should see search results page for "da vinci"

  @CWA-70
  Scenario: Main header tabs are not selected in search results page and footer is displayed
    When I search for "summer"
    Then search results should be displayed
    And main header tabs should not be selected
    And footer is displayed

  @CWA-54
  @unstable
  Scenario: View more books under a Promotable category on homepage
    When a promotable category has more books to display
    And I click on View more button
    Then I should see more books displayed

  @CWA-54
  Scenario: View more button changes to View less under a Promotable category on homepage
    When a promotable category has more books to display
    And I click on view more button until all the books are displayed
    Then the button should change to View less

  @CWA-54
  Scenario: View less button changes to View more under a Promotable category on homepage
    When a promotable category has more books to display
    And I click on view more button until all the books are displayed
    Then the button should change to View less
    And I click on View less button
    Then the button should change to View more

  @CWA-34
  @unstable
  Scenario:Book Component-List view Title display
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And  I select list view
    Then long titles should be displayed in two lines

  @CWA-34
  @unstable
  Scenario:Book Component-Grid view Title display
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And  I select grid view
    Then long titles should be truncated to fit within image

  @unstable
  @CWA-105
  Scenario Outline: Search word should not visible upon user navigating to another page
    When I search for "dan brown"
    Then "dan brown" should be visible in search bar
    And I click on the <page> link
    Then search term should not be visible in search bar

  Examples:
    | page         |
    | Featured     |
    | Categories   |
    | Best sellers |
    | New releases |
    | Top free     |
    | Authors      |

  #  @unstable
  @CWA-71
  @smoke
  Scenario: Best sellers page displayed
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And I should see Best sellers section header as Best sellers Top 100 this month
    And I should see 'Fiction' and 'Non-Fiction' tabs
    And I should see Grid view and List view buttons
    And I should see Main Footer

  @unstable
  @CWA-71
  Scenario: Promotable category-All time best selling books
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And I should see Promotions section header as All time best selling books
    And I should see 5 books being displayed

  @CWA-71
  Scenario: Best sellers page - Switching views
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And I select grid view
    Then I should see Fiction books in gird view
    And I select list view
    Then I should see Fiction books in list view

  @CWA-71
  Scenario: Best sellers page - Grid view not changing between tabs
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And I select grid view
    Then I should see Fiction books in gird view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in gird view

  @CWA-71
  Scenario: Best sellers page - List view not changing between tabs
    When I click on the Best sellers link
    Then I should be on the Best sellers page
    And I select list view
    Then I should see Fiction books in list view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in list view