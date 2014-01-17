Feature: Navigating through my account pages
  As a singed in Blinkbox books user
  I need the ability to view my account page
  So that I can view and update my account details

  Background:
    Given I am on the home page

  @smoke
  Scenario: Navigate to Order & Payment history
    Given I have signed in
    When I select Order & payment history link from drop down menu
    Then Your order & payment history page is displayed
    And Order & payment history tab is selected

  @smoke
  Scenario: Navigate to Your personal details
    Given I have signed in
    When I select Your personal details link from drop down menu
    Then Your personal details page is displayed
    And Your personal details tab is selected

  @smoke
  Scenario: Navigate to Your payments
    Given I have signed in
    When I select Your payments link from drop down menu
    Then Your payments page is displayed
    And Your payments tab is selected

  @smoke
  Scenario: Navigate to Your devices
    Given I have signed in
    When I select Your devices link from drop down menu
    Then Your devices page is displayed
    And Your devices tab is selected
    
  @wip @CWA-1027
  Scenario Outline: Navigate through FAQ links under Order & payment history
    Given I have signed in
    And I am on the Order & payment history tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window
  Examples:
    | link_text                                | support_page                             |
    | View all FAQs                            | support home                             |
    | What devices can I use to read my books? | What devices can I use to read my books? |
    | I bought a book but can't find it        | I bought a book but can't find it        |
    | How do I read books in the app?          | How do I read books in the app?          |

  Scenario Outline: Navigate through FAQ links under Your personal details
    Given I have signed in
    And I am on the Your personal details tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window
  Examples:
    | link_text                               | support_page                            |
    | View all FAQs                           | support home                            |
    | How do I change my billing address?     | How do I change my billing address?     |
    | How can I earn Tesco Clubcard points?   | How can I earn Tesco Clubcard points?   |
    | Can I delete my blinkbox books account? | Can I delete my blinkbox books account? |

  Scenario Outline: Navigate through FAQ links under Your payments
    Given I have signed in
    And I am on the Your payments tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window
  Examples:
    | link_text                          | support_page                       |
    | View all FAQs                      | support home                       |
    | How do I add a new payment method? | How do I add a new payment method? |
    | What are my payment options?       | What are my payment options?       |
    | Do you accept gift cards?          | Do you accept gift cards?          |

  Scenario Outline: Navigate through FAQ links under Your devices
    Given I have signed in
    And I am on the Your devices tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window
  Examples:
    | link_text                                | support_page                             |
    | View all FAQs                            | support home                             |
    | What devices can I use to read my books? | What devices can I use to read my books? |
    | How do I download the app?               | How do I download the app?               |
    | Problems installing the app              | Problems installing the app              |




