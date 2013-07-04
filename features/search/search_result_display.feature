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
      # There is an outstunding issue to fix the case sensitivity issue CP-254
      And I search for "dan brown"
     Then I should have a result page with term "dan brown" matching

  Scenario: The default mode is Grid
    Given the result is displayed in Grid mode

  Scenario: Check the sort options are present and accessible
    Given the result is displayed in Grid mode
      And I should see the sort option drop down

  Scenario: Switch from Grid mode to List mode
    Given the result is displayed in Grid mode
      And I change from Grid mode to List mode
     Then the result should be displayed in List mode

  Scenario: Switch back from List mode to Grid mode
    Given I change from Grid mode to List mode
     Then the result should be displayed in List mode
      And I change from List mode to Grid mode
     Then the result is displayed in Grid mode

#  Scenario: Check the number of return result is equal on both modes - Grid and List mode
#    Given the result is displayed in Grid mode
#      And I take the number books on Grid mode
#     Then I change from Grid mode to List mode
#      And the result should be displayed in List mode
#      And I take the number books on List mode
#     Then the number of books should match on both mode
#
#  Scenario: Check in the list mode for club card link/text details
#    Given the result is displayed in Grid mode
#      And I change from Grid mode to List mode
#     Then the result should be displayed in List mode
#      And the Tesco clubcard logo should be visible
#
#  Scenario: Search for a word that does not return any results
#    Given I type "fsjdfjsdjk" value in the search text box
#      And press return or click the search button
#     Then I should get a message which contains "fsjdfjsdjk"
#      And the list mode grid mode and sorting options should not appear
#      And 10 Bestselling books should be returned








