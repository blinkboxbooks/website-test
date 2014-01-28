Feature: Search Results page
  As a blinkbox book user
  I want to be able to search using a term associated with book
  So that I can see list of books with that search term

  The purpose of the search functionality is to enable users of blinkbox book, to search and retrieve a specific book
  or list of books with the search term present in the author, title or description section.

 Scenario: Search
    Given I am on the home page
    And I search for term "dan brown"
    Then I should print  list of books