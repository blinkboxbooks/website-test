@navigation
Feature: Navigation around the website
	As a user  
	I want to be able to navigate around the website
	So that I can find the page I'm looking for

Background:
	Given I am on the home page

Scenario: Clicking on the website logo 
	When I click on the website logo
	Then I should return to the home page


Scenario: Navigating to the help page from the footer
	When I click on the help link in the footer
	Then I should see the blinkbox help page

