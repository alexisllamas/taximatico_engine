Feature: Create session
  As a User
  I should be able to create a new session
  in order to login to the app

  Background:
    Given I send and accept JSON
    And a user with email "email@example.com" and password "supersecret" exists

  Scenario: Creating session successfully
    Given I send a POST request to "/users/sessions" with the following:
    """
    {
      "user" : {
        "email"    : "email@example.com",
        "password" : "supersecret"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should have "$..authentication_token" with a length of 1

  Scenario: Creating session unsuccessfully
    Given I send a POST request to "/users/sessions" with the following:
    """
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "user" : {
        "error" : "Couldn't find User"
      }
    }
    """

  Scenario: Creating session with wrong email
    Given I send a POST request to "/users/sessions" with the following:
    """
    {
      "user" : {
        "email"    : "not_email@example.com",
        "password" : "not_the_password"
      }
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "user" : {
        "error" : "Couldn't find User"
      }
    }
    """

  Scenario: Creating session with wrong password
    Given I send a POST request to "/users/sessions" with the following:
    """
    {
      "user" : {
        "email"    : "email@example.com",
        "password" : "not_the_password"
      }
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "user" : {
        "error" : "Invalid password"
      }
    }
    """
