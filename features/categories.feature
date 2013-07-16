Feature:  Checking Categories page content
  As a Blinkbox books user
  I want view all categories that have a valid id on categories page
  So that I can browse all books under a category

  Background: Opens Blinkbox books home page
    Given I am on the home page
    And I click on the Categories link
    Then I should be on the categories page

  Scenario: Display Categories in Desktop Mode
    When I am viewing in Desktop mode
     And page should display 5 categories in a row
  @wip
  Scenario: Display Categories in 10 inch tablet mode
    When I am viewing in 10 inch tablet mode
     And page should display 4 categories in a row

  @wip
   Scenario: Display Top Categories in 7 inch tablet mode
     When I am viewing in 7 inch tablet mode
      And page should display categories as list
      And page should not display the images

   @wip
   Scenario: Display Top Categories in mobile mode
     When I am viewing in mobile mode
     And page should display categories as list
     And page should not display the images

   Scenario: Valid category displayed
     When 109 is valid category id
     Then page should display the category
      And page should display category image
      And category name should be "Crime and Thriller"

   Scenario: Invalid category is not displayed
     When 123445 is invalid category id
     Then page should not display the category

   @wip @CWA-37
   Scenario: Valid category without image
     When 121 is valid category id
     Then page should display a category for id 121
      And category name should be "my-test-category"
      And page should display place holder image id 121

    @wip
    Scenario: Category with out descriptive name
      When 134 is valid category id
       And descriptive name is empty
      Then page should not display the category

    @wip
    Scenario: Recommended category
      When 1234 belongs to recommendable category
      Then it should have different styling






