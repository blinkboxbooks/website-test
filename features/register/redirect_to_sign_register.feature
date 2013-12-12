Feature: Redirect to Sign and register page
  As a Blinkbox books application
  I need to be redirect guest users to sign in register page when they try to access secured pages
  So that unauthorised access to secured pages can be prevented.


  Scenario Outline: Sign in register redirect for manage actions
    Given I am not signed in
    And I am on the home page
    When I select <account_option> link from drop down menu
    Then Sign in redirect page is displayed

  Examples:
    | account_option          |
    | Order & payment history |
    | Your personal details   |
    | Your payments           |
    | Your devices            |

  Scenario Outline: Sign in register redirect for buy action
    Given I am on the home page
    When I click Buy now on a <book_type> book as a not logged in user
    Then Sign in redirect page is displayed

  Examples:
    | book_type |
    | pay for   |
    | free      |

