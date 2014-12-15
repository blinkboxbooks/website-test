@navigation @ie @safari
Feature: Navigation around the website
  As a user
  I want to be able to navigate around the website
  So that I can find the page I'm looking for

  Background:
    Given I am on the home page

  @sanity @production
  Scenario: Clicking on the website logo
    When I click on the website logo
    Then Home page is displayed

  @sanity @production
  Scenario: Clicking on the About Blinkbox Books
    When I click on the About Blinkbox Books footer link
    Then About Blinkbox Books page is displayed

  @sanity @production
  Scenario: Navigating to the help site from the footer
    Given the blinkbox books help link is present in the footer
    Then the link should point to the blinkbox books help home page

  @sanity @production
  Scenario: Navigating to the blinkbox movies site from the footer
    Given the blinkbox movies link is present in the footer
    Then the link should point to the blinkbox movies home page

  @sanity @production
  Scenario: Navigating to the blinkbox music site from the footer
    Given the blinkbox music link is present in the footer
    Then the link should point to the blinkbox music home page

  @sanity @production
  Scenario: Navigating to the blinkbox books blogs from the footer
    Given the blinkbox books blog link is present in the footer
    Then the link should point to the blinkbox books blog

  @sanity @production
  Scenario: Navigating to the blinkbox careers site from the footer
    Given the blinkbox careers link is present in the footer
    Then the link should point to the blinkbox careers page

  @sanity @production
  Scenario: Navigate to Terms and Conditions page
    When I click on the Terms & conditions footer link
    Then Terms and conditions page is displayed in a new window

  @sanity @production
  Scenario: Navigate to Privacy & Cookies Policy page
    When I click on the Privacy & Cookies Policy footer link
    Then Terms and conditions page is displayed in a new window

  @sanity @production
  Scenario: Navigate to categories page
    When I click on the Categories header tab
    Then Categories page is displayed
    And main footer is displayed

  @sanity @production
  Scenario: Navigate to Bestsellers page
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed

  Scenario: Navigate to Bestsellers page
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And Bestsellers section header is Bestsellers Top 100 this month
    And I should see 'Fiction' and 'Non-Fiction' tabs
    And Grid view and List view buttons displayed
    And main footer is displayed

  @sanity @production
  Scenario: Navigate to New releases page
    When I click on the New releases header tab
    Then New releases page is displayed

  Scenario: Navigate to New releases page
    When I click on the New releases header tab
    Then New releases page is displayed
    And New releases section header is New releases
    And Grid view and List view buttons displayed

  @sanity @production
  Scenario: Navigate to Free eBooks page
    When I click on the Free eBooks header tab
    Then Free eBooks page is displayed

  Scenario: Navigate to Free eBooks page
    When I click on the Free eBooks header tab
    Then Free eBooks page is displayed
    And Free eBooks section header is Free eBooks
    And Grid view and List view buttons displayed
    And main footer is displayed

  @sanity @production
  Scenario: Navigate to Authors page
    When I click on the Authors header tab
    Then I should be on the Authors page

  Scenario: Navigate to Authors page
    When I click on the Authors header tab
    Then I should be on the Authors page
    And Bestselling authors section header is Top 100 bestselling authors this month
    And main footer is displayed

  @production
  Scenario Outline: Navigating through site by clicking Shop links from the hamburger Menu
    When I select <shop_link> link from the hamburger Menu
    Then <shop_link> page is displayed

  Examples:
    | shop_link    |
    | Categories   |
    | Bestsellers  |
    | Free eBooks  |
    | Authors      |
    | New releases |

  @CWA-1029 @unstable @production
  Scenario Outline: Clicking Support links from the hamburger Menu
    When I select <support_link> link from the hamburger Menu
    Then I am redirected to the "<support_page>" support page in a new window

  Examples:
    | support_link | support_page  |
    | FAQs         | View all FAQs |
    | Contact us   | Contact us    |

  @production
  Scenario: Navigate to home page from the hamburger Menu
    Given I am on Categories page
    When I select Featured link from the hamburger Menu
    Then Home page is displayed

  @sanity @production
  Scenario: Navigate to book details page
    When I select a book to view book details
    Then details page of the corresponding book is displayed
    And details of above book are displayed

  @sanity @production
  Scenario: Navigate to a Category page
    Given I am on Categories page
    When I click on a category
    Then Category page is displayed for the selected category

  @sanity @production
  Scenario: Read a sample
    Given I am on the Book Details page of a paid book
    And  the book reader is displayed
    And I am able to read the sample of corresponding book

  @production @CWA-2074
  Scenario: Clicking browser back should load previous search results pages if any
    When I search for following words
      | words     |
      | da vinci  |
      | dan brown |
    And I press browser back
    And I should see search results page for "da vinci" - pending CWA-2074

  @CWA-70 @production
  Scenario: Main header tabs are not selected in search results
    When I search for "summer"
    Then search results should be displayed
    And main header tabs should not be selected

  @production
  Scenario Outline: Search word should not visible upon user navigating to another page
    When I search for "dan brown"
    Then "dan brown" should be visible in search bar
    And I click on the <page> header tab
    Then search term should not be visible in search bar

  Examples:
    | page         |
    | Featured     |
    | Categories   |
    | Bestsellers  |
    | New releases |
    | Free eBooks  |
    | Authors      |

  Scenario: Promotable category - Daily bestsellers
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I should see Promotions section header as Daily bestsellers
    And I should see 5 books being displayed

  @production
  Scenario: Bestsellers page - Switching views
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select grid view
    Then I should see Fiction books in grid view
    And I select list view
    Then I should see Fiction books in list view

  @CWA-71 @production
  Scenario: Bestsellers page - Grid view not changing between tabs
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select grid view
    Then I should see Fiction books in grid view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in grid view

  @CWA-71 @production
  Scenario: Bestsellers page - List view not changing between tabs
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And I select list view
    Then I should see Fiction books in list view
    And I click on Non-Fiction tab
    Then I should see Non-Fiction books in list view

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
    When I scroll down to the footer
    Then the Help & Support footer visual should be displayed
    Then the How it Works footer visual should be displayed
    Then the Tesco Clubcard footer visual should be displayed
    Then the Redeem Code footer visual should be displayed

  @CWA-34 @manual
  Scenario:Book Component-List view Title display
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And  I select list view
    Then long titles should be displayed in two lines

  @CWA-34 @manual
  Scenario:Book Component-Grid view Title display
    When I click on the Bestsellers header tab
    Then Bestsellers page is displayed
    And  I select grid view
    Then long titles should be truncated to fit within image

  @manual
  Scenario Outline: Click on new release, free ebooks and authors tabs and verify pagination is shown
    When I click on the <page> header tab
    Then pagination is displayed

  Examples:
    | page         |
    | New releases |
    | Free eBooks  |
    | Authors      |