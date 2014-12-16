Feature: Returning user with expired cards buying book
  As a returning user with expired saved cards buying a book
  I should not be allowed to submit payments with expired cards
  So that I can complete purchase with new payment card or other stored cards.

  Scenario: User with one saved card that is expired buying book
    Given my default stored card has expired
    When I have selected to buy a paid book from the Book details page
    And I sign in to proceed with the purchase
    Then Confirm and pay page is displayed
    And Confirm and pay button should be disabled

  Scenario: User with multiple saved cards and a non-default card expired, buying book
    Given I have multiple saved cards
    And my default stored card has not expired
    When I have selected to buy a paid book from the Book details page
    And I sign in to proceed with the purchase
    Then Confirm and pay page is displayed
    And Confirm and pay button should be enabled

  Scenario:User with multiple saved cards and default card expired, buying a book
    Given I have multiple saved cards
    And my default stored card has expired
    When I have selected to buy a paid book from the Book details page
    And I sign in to proceed with the purchase
    Then Confirm and pay page is displayed
    And Confirm and pay button should be disabled
