Feature: Billing address form validation
  In order to prevent user from submitting invalid billing address details
  As a blinkbox books product owner
  I want the ability to validate billing address form

  Background:
    Given I am an existing user
    And I am buying a paid book as a logged in user

  Scenario Outline: Submit the payment with empty address field
    When I choose to pay with a new card
    And submit the payment details with empty <address_field>
    Then my payment is not successful
    And "<validation_error>" message is displayed

  Examples:
    | address_field    | validation_error           |
    | Address line one | Please enter your address  |
    | Town or city     | Please enter your city     |

  @pending @CWA-1487
  Examples:
    | address_field    | validation_error           |
    | Postcode         | Please enter your postcode |

  Scenario Outline: Submit payment with numeric input only for address fields
    When I choose to pay with a new card
    And submit the payment details with numeric input only for <address_field>
    Then my payment is not successful
    And "<validation_error>" message is displayed

  Examples:
    | address_field    | validation_error                              |
    | Address line one | Your address must not be a number             |
    | Address line two | Your address second line must not be a number |
    | Town or city     | Your city must not be a number                |

  @pending @CWA-1487
  Examples:
    | address_field    | validation_error                              |
    | Postcode         | Your postcode is not a valid postcode         |

  @pending @CWA-1487
  Scenario Outline: Malformed post code
    When I choose to pay with a new card
    And submit the payment details with malformed post code <value>
    Then my payment is not successful
    And "Your postcode is not a valid postcode." message is displayed

  Examples:
    | value     |
    | W5TA      |
    | W5555B    |
    | CR20 61A  |
    | WC$X8AQ   |
