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

  @pending
  Scenario: Click Got any questions links under Order & payment history
    Given I have signed in
    And I am on the Order & payment history tab
    When I click View all FAQs link
    Then support home page opens up in a new window
    When I click What devices can I use to read my books? link
    Then What devices can I use to read my books? support page opens up in a new window
    When I click I bought a book but can't find it link
    Then I bought a book but can't find it support page opens up in a new window
    When I click How do I read books in the app? link
    Then How do I read books in the app? support page opens up in a new window

  @pending
  Scenario: Click Got any questions links under Your personal details
    Given I have signed in
    And I am on the Your personal details tab
    When I click View all FAQs link
    When I click How do I change my billing address? link
    Then How do I change my billing address? support page opens up in a new window
    When I click How can I earn Tesco Clubcard points? link
    Then How can I earn Tesco Clubcard points? support page opens up in a new window
    When I click Can I delete my blinkbox books account? link
    Then Can I delete my blinkbox books account? support page opens up in a new window

  @pending
  Scenario: Click Got any questions links under Your payments
    Given I have signed in
    And I am on the Your payments tab
    When I click View all FAQs link
    Then support home page opens up in a new window
    When I click How do I add a new payment method? link
    Then How do I add a new payment method? support page opens up in a new window
    When I click What are my payment options? link
    Then What are my payment options? support page opens up in a new window
    When I click Do you accept gift cards? link
    Then Do you accept gift cards? support page opens up in a new window

  @pending
  Scenario: Click Got any questions links under Your devices
    Given I have signed in
    And I am on the Your devices tab
    When I click View all FAQs link
    Then support home page opens up in a new window
    When I click What devices can I use to read my books? link
    Then What devices can I use to read my books? support page opens up in a new window
    When I click How do I download the app? link
    Then How do I download the app? support page opens up in a new window
    When I click Problems installing the app link
    Then Problems installing the app support page opens up in a new window



