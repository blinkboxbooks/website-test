@wip
@suggestions
Feature: Suggestions for user search
  As a Blinkbox books user
  I want to get suggestions when I start searching for a book or author etc
  So that I can find quickly what I am looking for.



  Background: Opens Blinkbox books home page
    Given I am on the home page


  Scenario: Typing valid sequence of letters returns relevant suggestions
    When I enter "Gon" into search field
    Then search suggestions should be displayed
     And I should see at least 5 suggestions
     And all suggestions should contain search word "Gon"
    And the last suggestion should be equal to "Gon"


  Scenario: Exact match of letters should be first suggestion
    When I enter "Dan Brown" into search field
    Then search suggestions should be displayed
     And first suggestions should contain complete word "Dan Brown"
     And all suggestions should contain part of "Dan Brown"
     And the last suggestion should be equal to "Dan Brown"


  Scenario: Typing invalid sequence of letters does not return suggestions
    When I enter "afgehdkerydf" into search field
    Then search suggestions should not be displayed

  Scenario: Entering search term without space
    When I enter "Davinci" into search field
    Then in auto completion correct value "Da vinci" is displayed

  Scenario: Entering misspelled search term
    When I enter "addikted" into search field
    Then in auto completion correct value "addicted" is displayed

  @CP-254
  Scenario: Entering misspelled search term in upper case
    When I enter "ADDIKTED" into search field
    Then in auto completion correct value "ADDICTED" is displayed

  Scenario: Entering misspelled search term with apostrophe
    When I enter "childrn's tresure" into search field
    Then in auto completion correct values "children's" and "treasure" are displayed

