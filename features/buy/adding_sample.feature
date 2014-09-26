@buy @ie @safari
Feature: User adding sample to Library
  As a blink box books user
  I should be able add a sample to my library
  So that I can read sample of book offline

  @CWA-971
  Scenario Outline: First time user cancels adding sample
#   Given PENDING: CWA-971 First time user cancelling adding sample to library not redirected to the correct page
    Given I have identified a <book_type> book on the search results page to read sample offline
    And I am on the Register page
    When I cancel registration
    Then (Pending) I am redirected to Book details page

  Examples:
    | book_type |
    | paid      |
    | free      |

  @unstable
  Scenario Outline: First time user adding a sample to library
    Given I have identified a <book_type> book on the search results page to read sample offline
    When I select Read offline on the book details page
    And I register to proceed with adding sample
    Then adding sample is successful

 @smoke
 Examples: Adding a paid for book
    | book_type |
    | paid      |

  @unstable
  Examples:  Adding a free book
    | book_type |
    | free      |

  @unstable
  Scenario Outline: Returning user adding a sample to library
    Given I have identified a <book_type> book on the search results page to read sample offline
    When I select Read offline on the book details page
    And I sign in to proceed with adding sample
    Then adding sample is successful

  Examples:
    | book_type |
    | paid      |
    | free      |

  @negative
  Scenario Outline: Returning user attempting to add book sample that already exists in his library
    Given I have a <book_type> book as a sample in my library
    When I am on the Book Details page for the same <book_type> book
    And I try to add the book as a sample again
    And I sign in to proceed
    Then sample already exists in the library message is displayed on the confirm and pay page

  Examples:
    | book_type |
    | paid      |
    | free      |

  @negative
  Scenario Outline: Returning user attempting to add book sample of which full book already exists in his library
    Given I have purchased a <book_type> book
    When I am on the Book Details page for the same <book_type> book
    And I try to add the book as a sample
    And sign in to proceed
    Then book already exists in the library message is displayed on the confirm and pay page

  Examples:
    | book_type |
    | paid      |
    | free      |