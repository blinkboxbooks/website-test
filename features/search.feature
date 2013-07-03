@wip
@search
Feature:
  As a Blinkbox user
  I want to be able to search using a term
  So that I can see list of books with the search term

  The purpose of the search functionality is to enable users of Blinkbox to search and retrieve a specific book
  or list of books with the search term.

  Background:
    Given I am on the home page
      And I search for "Dan Brown"
     Then I should have a result page with term "Dan Brown" matching

  Scenario: The default view is Grid
      And the result should be displayed in Grid mode

  Scenario: Check the sort options are present and accessible
      And the result should be displayed in Grid mode
      And I should see the sort option drop down

  Scenario: Switch from Grid view to List View
     Given I change from Grid view to List view
       And the result should be displayed in List mode

  Scenario: Switch back to Grid view
    Given I change from Grid view to List view
     Then the result should be displayed in List view mode
     When I change from List view to Grid view
     Then the result should be displayed in Grid mode

  Scenario: Check the number of return result is equal on both views - Grid and List view
    Given the result should be displayed in Grid mode
      And the number books on Grid view should be "30"
     Then I change from Grid view to List view
      And the result should be displayed in List mode
      And the number books on List view should be "30"

  Scenario: Check in the list view for club card link/text details
    Given the result should be displayed in Grid mode
      And I change from Grid view to List view
     Then the result should be displayed in List mode
      And the Tesco clubcard logo should be visible

  Scenario: Search for a word that does not return any results
    Given I type "fsjdfjsdjk" value in the search text box
      And press return or click the search button
     Then I should get a message which contains "fsjdfjsdjk"
      And the list view grid view and sorting options should not appear
      And 10 Bestselling books should be returned








