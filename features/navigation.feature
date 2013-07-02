@navigation
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  Scenario: Clicking on the website logo
    When I click on the website logo
    Then I should return to the home page

# Scenario: Navigating with the categories link
#	Given the categories link is present in the header
#	Then the link should point to the categories page

  Scenario: Navigating to the help site from the footer
    Given the blinkbox books help link is present in the footer
    Then the link should point to the blinkbox books help home page

  Scenario: Navigating to the blinkbox movies site from the footer
    Given the blinkbox movies link is present in the footer
    Then the link should point to the blinkbox movies home page

  Scenario: Navigating to the blinkbox music site from the footer
    Given the blinkbox music link is present in the footer
    Then the link should point to the blinkbox music home page

  @desktop @mobile
  Scenario: Navigating with the categories link
    When I click on the categories link
    Then I should be on the categories page
