@navigation @ie @safari
Feature: Global Footer
  As a user
  I want to be able to navigate around the website using the footer
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @smoke @production
  Scenario: Clicking on the About Blinkbox Books
    When I click on the About Blinkbox Books footer link
    Then About Blinkbox Books page is displayed

  @smoke @production
  Scenario: Navigating to the help site from the footer
    Given the blinkbox books help link is present in the footer
    Then the link should point to the blinkbox books help home page

  @smoke @production
  Scenario: Navigating to the blinkbox movies site from the footer
    Given the blinkbox movies link is present in the footer
    Then the link should point to the blinkbox movies home page

  @smoke @production
  Scenario: Navigating to the blinkbox music site from the footer
    Given the blinkbox music link is present in the footer
    Then the link should point to the blinkbox music home page

  @smoke @production
  Scenario: Navigating to the blinkbox books blogs from the footer
    Given the blinkbox books blog link is present in the footer
    Then the link should point to the blinkbox books blog

  @smoke @production
  Scenario: Navigating to the blinkbox careers site from the footer
    Given the blinkbox careers link is present in the footer
    Then the link should point to the blinkbox careers page

  @smoke @production
  Scenario: Navigate to Terms and Conditions page
    When I click on the Terms & conditions footer link
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

  Scenario: Redesigned footer is displayed
    Then main footer is displayed
    When I scroll down to the footer
    Then the new Discover image should be displayed
    Then the new Register image should be displayed
    Then the new Download image should be displayed
    Then the new Read image should be displayed