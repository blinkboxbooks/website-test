  @pending @search
  Feature:
  As a blinkbox books user
  I want spelling suggestions to be displayed, when searching with misspelled words
  So that I can search with correct search words

  Background:
    Given I am on the home page


  Scenario Outline: Corrected word suggestions for misspelled search
    When I search for "<misspelled_word>"
    Then I should see a suggestion text with <corrected_spelling>
    When I click on <corrected_spelling> link
    Then search field is updated with <corrected_spelling>
    And  search results displayed for <corrected_spelling>

  Examples:
    | misspelled_word | corrected_spelling |
    | wolrd           | world              |
    | brownn          | browne             |
    | journie         | journey            |
    | samanta         | samantha           |
    | rachal joyce    | rachel joyce       |
