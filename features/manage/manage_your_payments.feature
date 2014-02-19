Feature: Update the Payment details of the user under 'your account'
  As a singed in Blinkbox books user
  I need the ability to update my payment details
  So I can keep my account up to date

  Background:
    Given I am on the home page

  @smoke
  Scenario: Delete a stored card
    Given I have a stored card
    And I have signed in
    And I am on the Saved cards tab
    When I delete the first card from the list
    Then there are no cards in my account
    And "Your payment card has been deleted. You can add new cards to your account while making a purchase" message is displayed

  @smoke  @data_dependent
  Scenario: Change default card
    Given I have multiple stored cards
    And I have signed in
    And I am on the Saved cards tab
    When I set a different card as my default card
    Then "Credit card set as default successfully" message is displayed
    And the selected card is displayed as my default card

  Scenario: First time user checking Payment details after buying a book and saving payment details
    Given I have selected to buy a pay for book from Home page
    And I register to proceed with purchase
    When I complete purchase by selecting to save the card details
    Then I can see the payment card saved in my Payment details

  Scenario: First time user checking Payment details after buying a book and not saving payment details
    Given I have selected to buy a pay for book from Home page
    And I register to proceed with purchase
    When I complete purchase by selecting not to save the card details
    Then I have no saved payment cards in my account

  Scenario: Returning user checking Payment details after buying a book with saved payments
    Given I have a stored card
    And I have selected to buy a pay for book from Home page
    And I sign in to proceed with purchase
    When I complete purchase by paying with saved card
    Then my saved Payment details are not updated

  Scenario: Returning user checking Payment details after buying a book with new payment and saving payment details
    Given I have a stored card
    And I have selected to buy a pay for book from Home page
    And I sign in to proceed with purchase
    When I complete purchase with new card by selecting to save Payment details
    Then I can see the payment card saved in my Payment details

  Scenario: Returning user checking Payment details after buying a book with new payment and not saving payment details
    Given I have a stored card
    And I have selected to buy a pay for book from Home page
    And I sign in to proceed with purchase
    When I complete purchase with new card by selecting not to save Payment details
    Then my saved Payment details are not updated