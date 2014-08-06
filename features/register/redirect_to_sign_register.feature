@production @register
Feature: Redirect to Sign and register page
  As a Blinkbox books application
  I need to be redirect guest users to sign in register page when they try to access secured pages
  So that unauthorised access to secured pages can be prevented.

 @ie @safari
  Scenario Outline: Sign in register redirect for manage actions under Account menu
    Given I am not signed in
    And I am on the home page
    When I select <account_option> link from drop down menu
    Then Sign in redirect page is displayed

  Examples:
    | account_option   |
    | Order history    |
    | Personal details |
    | Saved cards      |
    | Devices          |

  Scenario Outline: Sign in register redirect for buy action
    Given I am on the home page
    When I have selected to buy a <book_type> book on Book details page
    Then Sign in redirect page is displayed

  Examples:
    | book_type |
    | paid      |
    | free      |