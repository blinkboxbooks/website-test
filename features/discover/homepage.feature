Feature: Checking home page contents
  As a Blinkbox books user
  I want view relevant content for books home page
  So that I can find quickly what I am looking for.

  Background: Opens Blinkbox books home page
    Given I am on the home page
    @CWA-44
    Scenario: Main footer contents
      When I am viewing in Desktop mode
      Then main footer is displayed

    @CWA-44
    Scenario: Main footer content for 'Connect With us on'
      When I am viewing in Desktop mode
      Then main footer has "Connect with us" displayed
      And It has social media links

    @CWA-33
    Scenario: Homepage hero banner display
       And I am viewing in Desktop mode
      When number of banners is between 1 and 4
      Then homepage hero banner is displayed
       And banner has background images
       And homepage hero banner has navigation buttons


    @wip @CWA-33
    Scenario: Homepage hero banner manual navigation
       And I am viewing in Desktop mode
      When homepage hero banner is displayed
      And user clicks on navigation button
      Then next banner image should be displayed

    @wip @CWA-33
    Scenario: Homepage hero banner image layout
       And I am viewing in Desktop mode
      When homepage hero banner is displayed
       And banner has background images
      Then each banner image has title and subtitle
       And each banner image has Find out more button

    @wip @CWA-33
    Scenario: Click on banner image
      And I am viewing in Desktop mode
     When homepage hero banner is displayed
      And user clicks on banner image
     Then user is redirected to the banner content in the current window

    @wip @CWA-33
    Scenario: Click on Find out more button on banner image
       And I am viewing in Desktop mode
      When homepage hero banner is displayed
       And user clicks on 'Find out more' button
      Then user is redirected to the banner content in the current window

    @wip @CWA-33
    Scenario: Banner display on Mobile Portrait mode
       And I am viewing in Mobile Portrait mode
      When homepage hero banner is displayed
      Then banner image size should be reduced to one fourth of original
      And 'Find out more' button is not displayed

    @wip @CWA-33
    Scenario: Banner image without destination URL
      When homepage hero banner is displayed
       And banner image does not have a destination URL
      Then banner image should not be clickable




