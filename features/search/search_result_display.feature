@search @ie @safari
Feature: Search Results page
  As a blinkbox book user
  I want to be able to search using a term associated with book
  So that I can see list of books with that search term

  The purpose of the search functionality is to enable users of blinkbox book, to search and retrieve a specific book
  or list of books with the search term present in the author, title or description section.

  Background:
    Given I am on the home page
      # There is an outstanding issue to fix the case sensitivity issue CP-254
      And I search for term "dan brown" in grid view
     Then I should have a result page with at least one book written by "dan brown"

  Scenario: The default mode is Grid
    Given the result is displayed in Grid mode
    And I should see the sort option drop down

  Scenario: Switch from Grid mode to List mode
    Given the result is displayed in Grid mode
      And I change from Grid mode to List mode
     Then the result should be displayed in List mode
      And the Tesco clubcard logo should be visible

  Scenario: Switch back from List mode to Grid mode
    Given I change from Grid mode to List mode
     Then the result should be displayed in List mode
      And I change from List mode to Grid mode
     Then the result is displayed in Grid mode

  Scenario: Check the number of return result is equal on both modes - Grid and List mode
    Given the result is displayed in Grid mode
      And I take the number books on Grid mode
     Then I change from Grid mode to List mode
      And the result should be displayed in List mode
      And I take the number books on List mode
     Then the number of books should match on both mode

  Scenario: When user selects List view mode to display search results it should be set as default
    Given I change from Grid mode to List mode
    Then the result should be displayed in List mode
    And I search for term "da vinci"
    Then the result should be displayed in List mode