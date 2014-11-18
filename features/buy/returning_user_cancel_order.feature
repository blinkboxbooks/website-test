@buy
Feature: Returning user cancels order
  As a returning user of blinkbox books
  I want to the ability to cancel order
  So that I can cancel unwanted order.

  Background:
    Given I am returning user with saved payment details

  Scenario Outline: Returning user paying with saved card, user cancels order
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I sign in to proceed with the purchase
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

  Scenario Outline: Returning user paying with new payment, user cancels order
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I sign in to proceed with the purchase
    And I choose to pay with a new card
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

  Scenario Outline: Returning user's new payment has failed, user cancels order
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I sign in to proceed with the purchase
    And my payment failed at Braintree for not matching CVV
    When PENDING: @CWA-980 - Buy Process - Cancel Option - No Buttons
    # I cancel order
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

  Scenario Outline: Returning user has validation errors for new payment details, user cancels orders
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I sign in to proceed with the purchase
    And I choose to pay with a new card
    And I have validation error messages on the page
    When PENDING: @CWA-980 - Buy Process - Cancel Option - No Buttons
    # I cancel order
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

  Scenario Outline: Returning buying a free book, user cancels order
    Given I have selected to buy a <book_type> book from the <page_name> page
    And I sign in to proceed with the purchase
    When I cancel order
    And confirm cancel order
    Then I am redirected to <page_name> page

  Examples:
    | page_name      | book_type |
    | Search results | free      |
    | Book details   | free      |
    | Free eBooks    | free      |