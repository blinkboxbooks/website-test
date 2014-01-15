@pending
Feature: Journey scenarios in buy flow
  As a blinkbox books system
  I need to update Order History and Payment details when a user buys a book
  So that user's account information is up to date.

  Background:
   Given I am on the home page

Scenario: First time user checking Order history, Payment details after buying a book and saving payment details
  Given I have selected to buy a pay for book from Home page
  And I register to proceed with purchase
  When I complete purchase by selecting to save the card details
  Then book added to my Order & Payment history
  And  card added to my saved Payment details

Scenario: First time user checking Order history, Payment details after buying a book and not saving payment details
  Given I have selected to buy a pay for book from Home page
  And I register to proceed with purchase
  When I complete purchase by selecting not to save the card details
  Then book added to my Order & Payment history
  And  card not added to my saved Payment details

Scenario: Returning user checking Order history, Payment details after buying a book with saved payments
  Given I have a stored card
  And I have selected to buy a pay for book from Home page
  And I sign in to proceed with purchase
  When I complete purchase by paying with saved card
  Then book added to my Order & Payment history
  And  my saved Payment details are not updated
.
Scenario: Returning user checking Order history, Payment details after buying a book with new payment and saving payments
  Given I have a stored card
  And I have selected to buy a pay for book from Home page
  And I sign in to proceed with purchase
  When I complete purchase with new card by selecting to save card details
  Then book added to my Order & Payment history
  And  card added to my saved Payment details

Scenario: Returning user checking Order history, Payment details after buying a book with new payment and not saving payments
  Given I have a stored card
  And I have selected to buy a pay for book from Home page
  And I sign in to proceed with purchase
  When I complete purchase with new card by not selecting to save card details
  Then book added to my Order & Payment history
  And  card not added to my saved Payment details