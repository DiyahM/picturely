Feature: Search Twitter for Pictures
  As a visitor to the site
  I want to search for pictures on twitter by keyword
  So that I can pictures that I like

  Scenario: Search for San Francisco
    Given I am on the home page
    When I search for San Francisco
    Then I should see pictures about San Francisco
