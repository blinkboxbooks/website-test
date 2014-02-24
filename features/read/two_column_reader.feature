@pending
Feature: Read sample in the browser
As blinkbox books user
I should be able to save a sample or buy the book while reading in the browser
So I can continue reading on my device.

Background:
Given I am on the home page


Scenario Outline: Opening the sample in full screen mode
  <page>
  <full_screen_option>
  Examples:
  |page| full_screen_option|
  |book details page| view_full_screen|
  |search list view | try_it_for_free|

  Scenario: Close the full screen view

  Scenario: Navigating in the book

  Scenario: Hide & Show the slide options

  Scenario: Access the BUY NOW and Save Sample buttons
