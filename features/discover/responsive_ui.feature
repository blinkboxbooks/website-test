@CWA-37 @ie @safari @unstable @ui @production
Feature: Responsive page layout
  As a Blinkbox books user
  I want page layout to be adjusted to different screen sizes

  Background: Opens Blinkbox books home page
    Given I am on the home page
    And I click on the Categories header tab
    Then Categories page is displayed

  Scenario: Display Categories in Desktop Mode
    When I am viewing in Desktop mode
    And page should display 5 categories in a row

  Scenario: Display Categories in 10 inch tablet mode
    When I am viewing in 10 inch tablet mode
    And page should display 4 categories in a row

  Scenario: Display Categories in 7 inch tablet mode
    When I am viewing in 7 inch tablet mode
    And page should display categories as list

  Scenario: Display Categories in mobile portrait mode
    When I am viewing in Mobile Portrait mode
    And page should display categories as list

  Scenario: Display Categories in mobile landscape mode
    When I am viewing in Mobile Landscape mode
    And page should display categories as list