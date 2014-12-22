@navigation @ie @safari @production
Feature: Global Footer
  As a user
  I want to be able to navigate around the website using the footer
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @sanity
  Scenario: Footer is displayed
    When I look at the footer
    Then main footer is displayed
    And the Help & Support footer visual should be displayed
    And the How it Works footer visual should be displayed
    And the Tesco Clubcard footer visual should be displayed
    And the Redeem Code footer visual should be displayed
    And the footer copyright text should be displayed

  @CWA-2092
  Scenario: Footer with copyright text is displayed on the Confirm payment page
    Given I am on the Confirm and pay page trying to buy a paid book
    Then pending CWA-2092: the footer copyright text should be displayed
    But footer visuals should not be displayed
    And footer links should not be displayed

  @sanity
  Scenario: Clicking on the About Blinkbox Books
    When I click on the About Blinkbox Books footer link
    Then About Blinkbox Books page is displayed

  @sanity
  Scenario: Navigating to the help site from the footer
    Given the blinkbox books help link is present in the footer
    Then the link should point to the blinkbox books help home page

  @sanity
  Scenario: Navigating to the blinkbox movies site from the footer
    Given the blinkbox movies link is present in the footer
    Then the link should point to the blinkbox movies home page

  @sanity
  Scenario: Navigating to the blinkbox music site from the footer
    Given the blinkbox music link is present in the footer
    Then the link should point to the blinkbox music home page

  @sanity
  Scenario: Navigating to the blinkbox books blogs from the footer
    Given the blinkbox books blog link is present in the footer
    Then the link should point to the blinkbox books blog

  @sanity
  Scenario: Navigating to the blinkbox careers site from the footer
    Given the blinkbox careers link is present in the footer
    Then the link should point to the blinkbox careers page

  @sanity
  Scenario: Navigate to Terms and Conditions page
    When I click on the Terms & conditions footer link
    Then Terms and conditions page is displayed in a new window

  @sanity
  Scenario: Navigate to Privacy & Cookies Policy page
    When I click on the Privacy & Cookies Policy footer link
    Then Terms and conditions page is displayed in a new window

  Scenario: Top authors links from footer is dynamically generated
    Given there are top five authors on the Authors page
    Then the same Top authors are displayed in the footer

  Scenario: Top categories links from footer is dynamically generated
    Given there are top five categories on the Categories page
    Then the same Top categories are displayed in the footer

  Scenario: New releases links from footer is dynamically generated
    Given there are top five books on the New release page
    Then the same New releases are displayed in the footer
