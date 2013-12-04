@wip
Feature: Update the Personal details of the user
  As a singed in blinkbox books user
  I need the ability to access and edit my account pages

  Background:
    Given I am on the home page

Scenario: Successfully update the Clubcard number
  Given I am signed in
  And I am on the Your personal details tab
  When I edit my Clubcard number
  And I submit my personal details
  Then "Your personal details have been successfully updated." message is displayed
  And Clubcard number are as submitted

Scenario Outline: Update the Clubcard number with an invalid Clubcard
  Given I am signed in
  And I am on Your personal details tab
  When I edit my Clubcard number to <number>
  And I submit my personal details
  Then "This Tesco Clubcard number doesn't seem to be correct. Please check and try again" message is displayed
  And the <number> is not saved

Examples:
|number            |
|123456789012345678|
|634004025023057563|
|634004025023057562|

Scenario: Successfully delete a registered device

Scenario: Successfully rename a registered device

Scenario: Trying to update the Clubcard number when the access token has expired

Scenario: Trying to delete a card when the access token has expired
  Given I have a stored card
  And I have signed in
  And I am on the Your payments tab
  When I delete the first card from the list
  Then there are no cards in my account
  And "Your payment card has been deleted. You can add new cards to your account while making a purchase" message is displayed


Scenario: Trying to update personal information when the access token has expired
  Given I have signed in
  And I am on the Your personal details tab
  When I edit the first name and last name
  And I submit my personal details
  But the access token has expired
  ## Then I should see the soft sign in pop up

Scenario: Trying to update the Email address when access token has expired
  Given I have signed in
  And I am on the Your personal details tab
  When I edit email address
  And I submit my personal details
  But the access token has expired
##  Then I should see the soft sin in pop up

Scenario: Trying to delete a registered device when access token has expired

Scenario: Trying to rename a registered device when access token has expired

Scenario: Trying to make a non-default card default when the access token has expired.


