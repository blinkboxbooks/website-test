@manual
Feature: Update the Personal details of the user
  As a singed in blinkbox books user
  I need the ability to access and edit my account pages

  Background:
    Given I am on the home page


@manual
Scenario: Trying to update the Clubcard number when the access token has expired

@manual
Scenario: Trying to delete a card when the access token has expired
  Given I have a stored card
  And I have signed in
  And I am on the Saved cards tab
  When I delete the first card from the list
  Then there are no cards in my account
  And "Your payment card has been deleted. You can add new cards to your account while making a purchase" message is displayed

@manual
Scenario: Trying to update personal information when the access token has expired
  Given I have signed in
  And I am on the Personal details tab
  When I edit the first name and last name
  And I submit my personal details
  But the access token has expired
  ## Then I should see the soft sign in pop up

@manual
Scenario: Trying to update the Email address when access token has expired
  Given I have signed in
  And I am on the Personal details tab
  When I edit email address
  And I submit my personal details
  But the access token has expired
##  Then I should see the soft sin in pop up

@manual
Scenario: Trying to delete a registered device when access token has expired

@manual
Scenario: Trying to rename a registered device when access token has expired

@manual
Scenario: Trying to make a non-default card default when the access token has expired



