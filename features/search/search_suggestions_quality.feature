@suggestions @cp-275 @ie @safari
Feature: Suggestions for user search
  As a Blinkbox books user
  I want to get suggestions when I start searching for a book or author etc
  So that I can find quickly what I am looking for.

  Background: Opens Blinkbox books home page
    Given I am on the home page

  @data-dependent
  Scenario: Search suggestions displayed
    When I type "spring" into search field
    Then search suggestions should be displayed

  @sanity
  Scenario: Typing valid sequence of letters returns relevant suggestions
    When I type "Gone" into search field
    Then search suggestions should be displayed
     And I should see at least 5 suggestions
     And all suggestions should contain search word "Gone"

  Scenario: Exact match of letters should be first suggestion
    When I type "Dan Brown" into search field
    Then search suggestions should be displayed
    And first suggestions should contain complete word "Dan Brown"

  # Application does not display suggestions at all
  @pending
  Scenario: Entering search term without space
    When I type "Davinci" into search field
    Then in auto completion correct value "Da vinci" is displayed

  @pending
  Scenario: Entering misspelled search term
    When I type "addikted" into search field
    Then in auto completion correct value "addicted" is displayed

  @pending
  Scenario: Entering misspelled search term with apostrophe
    When I type "childrn's tresure" into search field
    Then in auto completion correct values "children's" and "treasure" are displayed

  Scenario: Select "More results for XX" from suggestion drop down menu
    When I type "Gone girl" into search field
    Then search suggestions should be displayed
    And last suggestion should contain More results for "Gone girl"
    When I select suggestion which contains More results for "Gone girl"
    Then search results should be displayed
