Feature: TEST

  Background:
    Given I am returning user with saved payment details

  Scenario Outline: Returning user paying with saved card, user cancels order
    Given I have selected to buy a <book_type> book from <page_name> page
    And I sign in to proceed with purchase
    When I cancel order
    And confirm cancel order
    Then I am redirected to <page_name> page

  Examples:
    | page_name | book_type |
    | Category  | pay for   |