@production @register
Feature: Redirect to Sign and register page
  As a Blinkbox books application
  I need to be redirect guest users to sign in register page when they try to access secured pages
  So that unauthorised access to secured pages can be prevented.

 @ie @safari
  Scenario Outline: Sign in register redirect for manage actions under Account menu
    Given I am not signed in
    And I am on the home page
    When I select <account_option> link from the hamburger Menu
    Then Sign in redirect page is displayed

  Examples:
    | account_option   |
    | Order history    |
    | Personal details |
    | Saved cards      |
    | Devices          |

  Scenario Outline: Sign in register redirect for buy action
    Given I am on the home page
    When I click Buy now on a <book_type> book as a not logged in user
    Then Sign in redirect page is displayed

  Examples:
    | book_type |
    | pay for   |
    | free      |

  @ie @safari
  Scenario Outline: Sign in register redirect for manage actions under main Menu
    Given I am not signed in
    And I am on the home page
    When I select <account_option> link from Your account under main Menu
    Then Sign in redirect page is displayed

  Examples:
    | account_option   |
    | Order history    |
    | Personal details |
    | Saved cards      |
    | Devices          |