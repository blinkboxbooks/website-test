@buy @ie @safari
Feature: User adding sample to Library
  As a blink box books user
  I should be able add a sample to my library
  So that I can read sample of book offline

  @CWA-971
  Scenario Outline: First time user cancels adding sample
    Given PENDING: CWA-971 First time user cancelling adding sample to library not redirected to the correct page
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

  @negative @CWA-1105
  Scenario Outline: Returning user attempting to a add book sample that already exists his in library
    Given PENDING: @CWA-1105, Sample already exists in library page not displayed
    Given  I have a <book_type> book sample in my library
    When I select above <book_type> book to add sample
    And sign in to proceed with adding sample
    Then sample already exists in the library message displayed in confirm and pay page

  Examples:
    | book_type |
    | pay for   |
    | free      |

  @negative  @CWA-1105
  Scenario Outline: Returning user attempting to a add book sample of which full book already exists in his library
    Given PENDING: @CWA-1105, Sample already exists in library page not displayed
    Given  I have a <book_type> book in my library
    When I select above <book_type> book to add sample
    And  sign in to proceed with adding sample
    Then sample already exists in the library message displayed in confirm and pay page

  Examples:
    | book_type |
    | pay for   |
    | free      |