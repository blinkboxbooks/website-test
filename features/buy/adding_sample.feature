@wip
Feature: User adding sample to Library
  As a blink box books user
  I should be able add a sample to my library
  So that I can read sample of book offline

  @wip @CWA-971
  Scenario Outline: First time user cancels adding sample
    Given I am on the home page
    And I have identified a <book_type> book to read sample offline
    And I am on Register page
    When I cancel registration
    Then I am redirected to Book details page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  Scenario Outline: First time user adding a sample to library
    Given I am on the home page
    And I have identified a <book_type> book to read sample offline
    When I select Read offline on the book details page
    And I register to proceed with adding sample
    Then adding sample is successful

  Examples:
    | book_type |
    | pay for   |
    | free      |

  Scenario Outline: Returning user adding a sample to library
    Given I have a stored card
    And I have identified a <book_type> book to read sample offline
    When I select Read offline on the book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful

  Examples:
    | book_type |
    | pay for   |
    | free      |