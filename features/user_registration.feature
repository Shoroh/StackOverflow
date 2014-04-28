Feature: User Registration
  Scenario: User registers successfully via register form
    Given I am a guest
    When I fill the registering form with valid data
    Then I should be registered in application