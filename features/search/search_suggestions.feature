@manual @CWA-66 @to_refactor
Feature: Checking for the Search suggestions on the home page.
  As a Blinkbox books user
  I want view the Search suggestions as I type in the Search text box
  So that it's easy for me to choose from the suggestions.


  Scenario: entering search string
    Given text is entered in the search field
    When the user enters at least 1 character in the search field
    Then predictive search suggestions become visible as the user enters the text
    And a magnifying icon + the entered text is visible below the search suggestions
    And the entered text is highlighted

  Scenario: Display the author or book symbol
    Given a predictive search suggestion is available
    When type = book THEN show book icon before the suggestion
    When type = author THEN show author icon before the suggestion

  Scenario: Submitting a search by selecting the search suggestion
    Given the user submits the query with the search button by selecting any of the search suggestions
    Then a search is performed using the selected text as search string
    And the user is redirected to the search results page
    And the user can see the search results for the submitted search query


  Scenario: Submitting a search by pressing the return key on the device
    Given the user submits the query with the search button by selecting the pressing the return key on the device
    Then a search is performed using the selected text as search string
    And the user is redirected to the search results page
    And the user can see the search results for the submitted search query