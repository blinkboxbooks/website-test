@CWA-37
Feature:  Checking Categories page content
  As a Blinkbox books user
  I want view all categories that have a valid id on categories page
  So that I can browse all books under a category

  Background: Opens Blinkbox books home page
    Given I am on the home page
    And I click on the Categories link
    Then Categories page is displayed

  @manual
  Scenario: Display Categories in Desktop Mode
    When I am viewing in Desktop mode
     And page should display 5 categories in a row

  @manual
  Scenario: Display Categories in 10 inch tablet mode
    When I am viewing in 10 inch tablet mode
     And page should display 4 categories per a row

  @manual
   Scenario: Display Categories in 7 inch tablet mode
     When I am viewing in 7 inch tablet mode
      And page should display categories as list

   @manual
   Scenario: Display Categories in mobile portrait mode
     When I am viewing in Mobile Portrait mode
     And page should display categories as list

   @manual
  Scenario: Display Categories in mobile landscape  mode
    When I am viewing in Mobile Landscape mode
    And page should display categories as list

   @data-dependent
   Scenario: Valid category displayed
     When 57 is valid category id
     Then page should display the category
      And page should display category image
      And category name should be "Thriller & Suspense"

   Scenario: Invalid category is not displayed
     When 123445 is invalid category id
     Then page should not display the category

   @manual @CWA-37
   Scenario: Valid category without image
     When 121 is valid category id without image
     Then page should display a category for id 121
      And category name should be "my-test-category"
      And page should display place holder image id 121

    @manual
    Scenario: Category with out descriptive name
      When 134 is valid category id without descriptive name
       And descriptive name is empty
      Then page should not display the category

    @manual
    Scenario: Recommended category
      When 1234 belongs to recommendable category
      Then it should have different styling






