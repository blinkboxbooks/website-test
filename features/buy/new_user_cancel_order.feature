@buy @pending
Feature: New user cancels order
  As a new user of blinkbox books
  I want to the ability to cancel order
  So that I can cancel unwanted order.


  Background:
    Given I am on the home page

  Scenario Outline: First time user cancels order in payments page
    Given I have identified a <book_type> book to buy
    And I register to proceed with purchase
    When I cancel order
    And confirm cancel
    Then I am redirected to Home page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  Scenario Outline: First time user cancels order in registration page
    Given I have identified a <book_type> book to buy
    And I am on Register page
    When I cancel registration
    And confirm cancel
    Then I am redirected to Home page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  Scenario Outline: First time user cancels adding sample
    Given I have identified a <book_type> book to add sample
    And I am on Register page
    When I cancel registration
    Then I am redirected to Home page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  Scenario Outline: Canceling order in registration page redirects to correct page
    Given I have clicked buy now for a book on <page_name> page
    And I am on Register page
    When I cancel registration
    Then I am redirected to <page>
   Examples:
   |page_name |
    |Home |
    |Search results |
    |Book details   |
    |Category  |
    |Best Sellers |
    |New Releases |
    |Free books   |
