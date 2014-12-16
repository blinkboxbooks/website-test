@navigation @ie @safari @production
Feature: Global Header
  As a user
  I want to be able to navigate around the website using the header
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @sanity
  Scenario: Clicking on the website logo
    When I click on the Bestsellers header tab
    And I click on the website logo
    Then Home page is displayed

  @sanity
  Scenario Outline: Navigate with header tabs
    When I click on the <tab_name> header tab
    Then <tab_name> page is displayed
    And main header is displayed
    And main footer is displayed

  Examples:
    | tab_name     |
    | Categories   |
    | Bestsellers  |
    | New releases |
    | Free eBooks  |
    | Authors      |

  Scenario Outline: Navigating through site by clicking Navigation links from the hamburger Menu
    When I select <navigation_link> link from the hamburger Menu
    Then <navigation_link> page is displayed

  Examples:
    | navigation_link |
    | Categories      |
    | Bestsellers     |
    | New releases    |
    | Free eBooks     |
    | Authors         |

  @CWA-1029 @unstable
  Scenario Outline: Clicking Support links from the hamburger Menu
    When I select <support_link> link from the hamburger Menu
    Then I am redirected to the "<support_page>" support page in a new window

  Examples:
    | support_link | support_page  |
    | FAQs         | View all FAQs |
    | Contact us   | Contact us    |

  Scenario: Navigate to home page from the hamburger Menu
    Given I am on Categories page
    When I select Featured link from the hamburger Menu
    Then Home page is displayed