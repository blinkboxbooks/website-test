@manage @ie @safari
Feature: Navigating through my account pages
  As a singed in Blinkbox books user
  I need the ability to view my account page
  So that I can view and update my account details

  Background:
    Given I am on the home page

  @smoke @production
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

  @smoke @production
  Scenario Outline: Signed in user accessing account navigation links from main Menu
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

  @CWA-1027 @production
  Scenario: Navigate through FAQ links under Order & payment history
    Given I have signed in
    When I am on the Order history tab
    Then following FAQ links are displayed:
      | support links                            |
      | View all FAQs                            |
      | What devices can I use to read my books? |
      | I bought a book but can’t find it        |
      | How do I read books in the app?          |
    And clicking above FAQ link opens relevant support page in a new window

  @production
  Scenario: Navigate through FAQ links under Personal details
    Given I have signed in
    When I am on the Personal details tab
    Then following FAQ links are displayed:
      | support links                           |
      | View all FAQs                           |
      | How do I change my billing address?     |
      | How can I earn Tesco Clubcard points?   |
      | Can I delete my blinkbox books account? |
    And clicking above FAQ link opens relevant support page in a new window

  @production
  Scenario: Navigate through FAQ links under Your payments
    Given I have signed in
    When I am on the Saved cards tab
    Then following FAQ links are displayed:
      | support links                      |
      | View all FAQs                      |
      | How do I add a new payment method? |
      | What are my payment options?       |
      | Do you accept gift cards?          |
    And clicking above FAQ link opens relevant support page in a new window

  @production
  Scenario: Navigate through FAQ links under Your devices
    Given I have signed in
    When I am on the Devices tab
    Then following FAQ links are displayed:
      | support links                            |
      | View all FAQs                            |
      | What devices can I use to read my books? |
      | How do I download the app?               |
      | Problems installing the app              |
    And clicking above FAQ link opens relevant support page in a new window

  @CWA-615 @production
  Scenario Outline: User with no associated payment, order or device information check their account information
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

  Scenario: FAQ links on Order complete page
    Given I have a stored card
    And I have selected to buy a pay for book from Home page
    And I sign in to proceed with purchase
    When I complete purchase by paying with saved card
    Then following FAQ links are displayed on confirmation page:
      | support links                            |
      | What devices can I use to read my books? |
      | How do I download the app?               |
      | How do I download books?                 |
   Given PENDING: @CWA-1311, FAQ Links on order confirmation page pointing to old url (zendesk)
   And clicking above FAQ link opens relevant support page in a new window

   Scenario: Continue shopping button on Order complete page
     Given I have a stored card
     And I have selected to buy a pay for book from Home page
     And I sign in to proceed with purchase
     When I complete purchase by paying with saved card
     When I click the "Continue shopping" button on order complete page
     Then I am redirected to Home page

    Scenario: Download free app button on Order complete page
      Given I have a stored card
      And I have selected to buy a pay for book from Home page
      And I sign in to proceed with purchase
      When I complete purchase by paying with saved card
      Then the "Download the free app" button is displayed on the order complete page
      Given PENDING: @CWA-1311, FAQ Links on order confirmation page pointing to old url (zendesk)
      When I click the "Download the free app" button on order complete page
      Then the "Download the free app" support page opens up in a new window
