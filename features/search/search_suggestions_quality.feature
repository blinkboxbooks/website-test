@suggestions @cp-275 @ie @safari @smoke @unstable
Feature: Suggestions for user search
  As a Blinkbox books user
  I want to get suggestions when I start searching for a book or author etc
  So that I can find quickly what I am looking for.

  Background: Opens Blinkbox books home page
    Given I am on the home page

  @smoke @production @data-dependent
  Scenario: Search suggestions displayed
    When I type "spring" into search field
    Then search suggestions should be displayed

  Scenario: Typing valid sequence of letters returns relevant suggestions
    When I type "Gone" into search field
    Then search suggestions should be displayed
     And I should see at least 5 suggestions
     And all suggestions should contain search word "Gone"

  Scenario: Typing invalid sequence of letters does not return suggestions
    When I type "#$£%^" into search field
    Then search suggestions should not be displayed

  Scenario: Entering search term without space
    When I type "Davinci" into search field
    Then in auto completion correct value "Da vinci" is displayed

  Scenario: Entering misspelled search term
    When I type "addikted" into search field
    Then in auto completion correct value "addicted" is displayed

  Scenario: Entering misspelled search term with apostrophe
    When I type "childrn's tresure" into search field
    Then in auto completion correct values "children's" and "treasure" are displayed

