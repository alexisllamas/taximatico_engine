Feature: Destroy session
  As a User
  I should be able to destroy a user session
  in order to not be able to login to the app

  Background:
    Given I send and accept JSON
    And a user with email "email@example.com" and password "supersecret" exists
    And its authentication token is "foobar123"

  Scenario: Destroy session successfully
    Given I send a DELETE request to "/users/sessions/me" with the following:
    """
    {
      "authentication_token" : "foobar123"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "user" : {
        "message" : "Successfully destroyed session"
      }
    }
    """

  Scenario: Destroy session unsuccessfully
    Given I send a DELETE request to "/users/sessions/me" with the following:
    """
    {
      "authentication_token" : "wrong_token"
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
