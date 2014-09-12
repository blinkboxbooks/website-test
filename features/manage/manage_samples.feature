@manage
Feature: Manage Samples under My account section.
  As a blinkbox books user
  I need the ability to view, buy, remove my samples from the Samples tab
  So that I can can manage my samples books well from the web.

  Background:
    Given I am on the home page

  Scenario: Sample tab view for a user with no samples in their account
    Given I sign in as a user who has no samples in their account
    When I am on the Samples tab
    Then "You haven't got any samples yet. Why not give these a try?" message is displayed
    And the Books from the Highlight section are shown

  @pending
  Scenario: Successfully adding a sample to the account
    Given I am logged in as a user with some book samples in my account
    When I add a Sample to my account
    Then it should appear in my ‘Samples’ tab under the 'Account' menu

  @pending
  Scenario: Successfully buying from the samples tab
    Given I am logged in as a user with some book samples in my account
    When I am on the Samples tab
    And I click on the 'Buy now' button to purchase the full version of a book
    And I confirm my purchase
    When I go back to the 'Samples' tab
    Then the purchased book should be removed from the ‘Samples’ tab
    And it should be added to my 'Order and Payment history' tab

  @pending
  Scenario: Cancel buying from the samples tab
    Given I am logged in as a user with some book samples in my account
    When I am on the ‘Samples’ tab
    And I click on the 'Buy now' button to purchase the full version of a book
    But I cancel the purchase on the confirmation page
    Then I should be redirected to the 'Samples' tab

  @pending
  Scenario: Viewing the sample from the Samples tab
    Given I am logged in as a user with some book samples in my account
    When I am on the ‘Samples’ tab
    And I click on ‘view sample’
    Then I am redirected to the book details page of that book

  @pending
  Scenario: Successfully removing a sample from the account
    Given I am logged in as a user with some book samples in my account
    When I am on the ‘Samples’ tab
    And I try to remove a sample book
    And confirm my action
    Then the sample is successfully removed from my account

  @pending
  Scenario: Cancel removing a sample from the account
    Given I am logged in as a user with some book samples in my account
    When I am on the ‘Samples’ tab
    And I try to remove a sample book
    But then I decide to keep it
    Then the sample is not removed from my account

  @manual
  Scenario: Verify on removing a sample from the browser, the sample is removed from the android and iOS apps

  @manual
  Scenario: Verify pagination on the Samples tab
    Given I am logged in as a user who has 19 samples
    And I am on the 'Samples' tab
    Then I should see the first 10 samples
    When I click on the show more button
    Then it shows more 9 more books
    And does not show the show more button
    When I add a book as a sample
    And verify that I now have 20 books
    When I delete a sample
    And visit the Samples tab again
    Then I do not see the show more button if I have clicked on it once