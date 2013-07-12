@navigation
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

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
    Then I should be on the categories page

   @CWA-105
  Scenario Outline: Search word should not visible upon user navigating to another page
    When I search for "dan brown"
    Then "dan brown" should be visible in search bar
     And I click on the <page> link
    Then search term should not be visible in search bar

    Examples:
     |page|
     |Featured     |
     |Categories   |
     |Best Sellers |
     |New Releases |
     |Top Free     |
     |Authors      |

  @CWA-87
  Scenario: Clicking browser back should load previous search results pages if any
    When I search for following words
    |words|
    |da vinci    |
    |dan brown   |
    And I press browser back
    And I should see search results page for "da vinci"

  @CWA-70
  Scenario: Main header tabs are not selected in search results page and footer is displayed
    When I search for "summer"
    Then search results should be displayed
    And main header tabs should not be selected
    And footer is displayed

  @CWA-54
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

