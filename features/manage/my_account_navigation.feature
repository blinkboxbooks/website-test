Feature: Navigating through my account pages
  As a singed in Blinkbox books user
  I need the ability to view my account page
  So that I can view and update my account details

  Background:
    Given I am on the home page

  @smoke
  Scenario Outline: Signed in user accessing account navigation links from Account Menu
    Given I have signed in
    When I select <my_account_option> link from drop down menu
    Then <my_account_page> page is displayed
    And <my_account_page> tab is selected

  Examples:
    | my_account_option | my_account_page         |
    | Order history     | Order & payment history |
    | Personal details  | Your personal details   |
    | Saved cards       | Your payments           |
    | Devices           | Your devices            |

  @smoke @pending
  Scenario Outline: Signed in user accessing account navigation links from main Menu
    Given I have signed in
    When I select <my_account_option> link from Your account under main Menu
    Then <my_account_page> page is displayed
    And <my_account_option> tab is selected

  Examples:
    | my_account_option | my_account_page         |
    | Order history     | Order & payment history |
    | Personal details  | Your personal details   |
    | Saved cards       | Your payments           |
    | Devices           | Your devices            |

  @CWA-1027
  Scenario Outline: Navigate through FAQ links under Order & payment history
    Given I have signed in
    And I am on the Order history tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window

  Examples:
    | link_text                                | support_page                             |
    | View all FAQs                            | support home                             |
    | What devices can I use to read my books? | What devices can I use to read my books? |
    | I bought a book but can’t find it        | I bought a book but can't find it        |
    | How do I read books in the app?          | How do I read books in the app?          |

  Scenario Outline: Navigate through FAQ links under Personal details
    Given I have signed in
    And I am on the Personal details tab
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
    And I am on the Saved cards tab
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
    And I am on the Devices tab
    When I click "<link_text>" FAQ link
    Then I am redirected to the "<support_page>" page in a new window

  Examples:
    | link_text                                | support_page                             |
    | View all FAQs                            | support home                             |
    | What devices can I use to read my books? | What devices can I use to read my books? |
    | How do I download the app?               | How do I download the app?               |
    | Problems installing the app              | Problems installing the app              |

  @CWA-615
  Scenario Outline: User with no orders in the past, no saved payments, no associated devices checking account information
    Given I am returning user with no <user_type>
    And I have signed in
    When I select <account_link> link from drop down menu
    Then <account_page> page is displayed
    And <account_page> tab is selected
    And "<account_message>" message is displayed

  Examples:
    | user_type           | account_link  | account_page            | account_message                                     |
    | associated devices  | Devices       | Your devices            | You currently have 0 devices linked to your account |
    | orders in the past  | Order history | Order & payment history | You haven't bought anything from blinkbox books yet |
    | saved payment cards | Saved cards   | Your payments           | You have no payment cards saved to your account     |



