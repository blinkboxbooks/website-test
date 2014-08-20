@manage
Feature: Manage Samples under My account section.
  As a blinkbox books user
  I need the ability to view, buy, remove my samples from the Samples tab
  So that I can can manage my samples books well from the web.

  Background:
    Given I am on the home page

  Scenario: Verifying user has no samples in their account.
    Given I sign in as a user who has no samples in their account
    And I am on the Samples tab
    Then I see a message
    And the Books from the Highlight section

  @pending
  Scenario: Successfully adding a sample to the account.
    Given I am logged in
    When I add a Samples tab
    Then it should appear in my ‘Samples’ tab

  @pending
  Scenario: Successfully buying from the samples tab
    Given I am logged in
    When I am on the Samples tab
    And I click to buy a book
    And I click on confirm
    Then the book is removed from the ‘Samples’ tab
    And added to my order and payment history tab

  @pending
  Scenario: Cancel buying from the samples tab
    Given I am logged in
    When I am on the ‘Samples’ tab
    And I click to buy a book
    And cancel the purchase on the confirmation page
    Then I am redirected to the 'Samples' tab

  @pending
  Scenario: Viewing the sample from the Samples tab
    Given I am logged in
    When I am on the ‘Samples’ tab
    And I click on ‘view sample’
    Then I am redirected to the book details page

  @pending
  Scenario: Successfully removing a sample from the account.
    Given I am logged in
    When I am on the ‘Samples’ tab
    And I try to remove a sample book
    And confirm my action
    Then the sample is successfully removed from my account

  @pending
  Scenario: Cancel removing a sample from the account.
    Given I am logged in
    When I am on the ‘Samples’ tab
    And I try to remove a sample book
    And decide to keep it
    Then the sample is not removed from my account

  @manual
  Scenario: Verify on removing a sample from the browser, the sample is removed from the android and iOS apps.

  @manual
  Scenario: Verify pagination on the Samples tab
    Given I am logged in as a user who has 19 samples
    And I am on the 'Samples' tab
    When I click on the show more button
    Then it shows more 9 more books
    And does not show the show more button
    When I add a book as a sample
    And verify that I now have 20 books
    When I delete a sample
    And visit the Samples tab again
    Then I do not see the show more button if I have clicked on it once