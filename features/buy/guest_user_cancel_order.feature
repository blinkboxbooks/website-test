@buy
Feature: Guest user cancels order
  As a guest user of blinkbox books
  I want to the ability to cancel order
  So that I can cancel unwanted order.

  Scenario Outline: Guest user cancels order in payments page
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I register to proceed with the purchase
    When I cancel order
    And confirm cancel order
    Then I am redirected to <page_name> page

  Examples:
    | page_name      | book_type |
    | Home           | paid      |
    | Search results | paid      |
    | Book details   | paid      |
    | Category       | paid      |
    | Bestsellers    | paid      |
    | New releases   | paid      |
    | Search results | free      |
    | Book details   | free      |
    | Free eBooks    | free      |

  Scenario Outline: Guest user cancels order in registration page
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I have selected register option
    When I cancel registration
    And confirm cancel registration
    Then I am redirected to <page_name>  page

  Examples:
    | page_name      | book_type |
    | Home           | paid      |
    | Search results | paid      |
    | Book details   | paid      |
    | Category       | paid      |
    | Bestsellers    | paid      |
    | New releases   | paid      |
    | Search results | free      |
    | Book details   | free      |
    | Free eBooks    | free      |