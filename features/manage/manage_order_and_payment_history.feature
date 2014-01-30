@pending
Feature: Manage Order and Payment history under My account section.
  As a blinkbox books user
  I need to ability to check Order and Payment history
  So that I can see the books I have purchased.

  Background:
    Given I am on the home page

  Scenario: First time user checking Order history, Payment details after buying a book and saving payment details
    Given I have selected to buy a pay for book from Home page
    And I register to proceed with purchase
    When I complete purchase by selecting to save the card details
    Then I can see this book in my Order & Payment history

  Scenario: Returning user checking Order history, Payment details after buying a book with saved payments
    Given I have a stored card
    And I have selected to buy a pay for book from Home page
    And I sign in to proceed with purchase
    When I complete purchase by paying with saved card
    Then I can see this book in my Order & Payment history
