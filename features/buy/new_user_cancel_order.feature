@buy
Feature: New user cancels order
  As a new user of blinkbox books
  I want to the ability to cancel order
  So that I can cancel unwanted order.


  Background:
    Given I am on the home page

  Scenario Outline: First time user cancels order in payments page
    Given I have selected to buy a <book_type> book from <page_name> page
    And I register to proceed with purchase
    When I cancel order
    And confirm cancel order
    Then I am redirected to <page_name> page

  Examples:
    | page_name      | book_type |
    | Home           | pay for   |
    | Search results | pay for   |
    | Book details   | pay for   |
    | Category       | pay for   |
    | Bestsellers    | pay for   |
    | New releases   | pay for   |
    | Search results | free      |
    | Book details   | free      |
    | Free eBooks     | free      |

  Scenario Outline: First time user cancels order in registration page
    Given I have selected to buy a <book_type> book from <page_name> page
    And I have selected register option
    When I cancel registration
    And confirm cancel registration
    Then I am redirected to <page_name>  page

  Examples:
    | page_name      | book_type |
    | Home           | pay for   |
    | Search results | pay for   |
    | Book details   | pay for   |
    | Category       | pay for   |
    | Bestsellers    | pay for   |
    | New releases   | pay for   |
    | Search results | free      |
    | Book details   | free      |
    | Free eBooks     | free      |