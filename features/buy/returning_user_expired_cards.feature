Feature: Returning user with expired cards buying book
  As a returning user with expired cards
  I want to be shown if my cards are expired
  So that I can complete purchase with new payment or other stored cards.

  #defualt_expiredcard@aa.com, test1234
  @wip
  Scenario: Returning user with only default expired card buying book
    Given I have default expired stored card
    When I click Buy now on a pay for book as a logged in user
    Then Confirm page should be displayed
    And Confirm and pay button should be disabled
    
  #nondefualt_expiredcard@aa.com, test1234
  @wip
  Scenario: Returning user with non-default expired card buying book
    Given I have multiple saved cards with non-default card expired
    When I click Buy now on a pay for book as a not logged in user
    And I sign in to proceed with purchase
    Then confirm page should be displayed
    And Confirm and pay button should be enabled.

  #multiplecards_defaultexpired@aa.com, test1234
  @wip
  Scenario: Returning user with multiple saved cards and default card expired, buying a book
    Given I have multiple saved cards with default card expired
    When I click Buy now on a pay for book as a logged in user
    Then Confirm page should be displayed
    And Confirm and pay button should be disabled