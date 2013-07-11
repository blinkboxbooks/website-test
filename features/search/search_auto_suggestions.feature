
@suggestions @cp-275
Feature: Suggestions for user search
  As a Blinkbox books user
  I want to get suggestions when I start searching for a book or author etc
  So that I can find quickly what I am looking for.



  Background: Opens Blinkbox books home page
    Given I am on the home page

  @wip
  Scenario: Typing valid sequence of letters returns relevant suggestions
    When I type "Gon" into search field
    Then search suggestions should be displayed
     And I should see at least 5 suggestions
     And all suggestions should contain search word "Gon"
     And the last suggestion should be equal to "Gon"

   @wip
  Scenario: Exact match of letters should be first suggestion
    When I type "Dan Brown" into search field
    Then search suggestions should be displayed
     And first suggestions should contain complete word "Dan Brown"
     And all suggestions should contain part of "Dan Brown"
     And the last suggestion should be equal to "Dan Brown"


  Scenario: Typing invalid sequence of letters does not return suggestions
    When I type "#$£%^" into search field
    Then search suggestions should not be displayed

  @wip
  Scenario: Entering search term without space
    When I type "Davinci" into search field
    Then in auto completion correct value "Da vinci" is displayed
  @wip
  Scenario: Entering misspelled search term
    When I type "addikted" into search field
    Then in auto completion correct value "addicted" is displayed

  @wip
  Scenario: Entering misspelled search term with apostrophe
    When I type "childrn's tresure" into search field
    Then in auto completion correct values "children's" and "treasure" are displayed

