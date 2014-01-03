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
    And I am on the Your payments tab
    When I delete the first card from the list
    Then there are no cards in my account
    And "Your payment card has been deleted. You can add new cards to your account while making a purchase" message is displayed

  @smoke  @data_dependent
  Scenario: Change default card
    Given I have multiple stored cards
    And I have signed in
    And I am on the Your payments tab
    When I set a different card as my default card
    Then "Credit card set as default successfully" message is displayed
    And the selected card is displayed as my default card