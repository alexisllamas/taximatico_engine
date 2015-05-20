Feature: Request driver
  As a user
  I should be able to request a driver
  in order have a cab ride

  Background:
    Given I send and accept JSON
    And the time is 2015-05-04 22:00
    And the following drivers exist:
      | name              | taxi_number | latitude  | longitude    |
      | Juan Perez        | 5           | 19.264997 | -103.7108419 |
      | John Doe          | 22          | 19.265189 | -103.713567  |
      | Maria Guadalupe   | 10          | 19.269585 | -103.716614  |
    Given a user with phone number "+523121125642" exists
    And his authentication token is "foobar"
    And I set the request with the header "X-AUTHENTICATION-TOKEN" as "foobar"

  Scenario: Request a driver successfully
    Given I send a POST request to "/users/driver_requests" with the following:
    """
    {
      "latitude" : "19.264987",
      "longitude" : "-103.710863"
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "status"  : "ok",
      "driver_request" : {
        "id" : 1,
        "user_id" : 1,
        "driver_id" : null,
        "status" : "pending",
        "created_at" : "2015-05-04T22:00:00.000Z",
        "expires_at" : "2015-05-04T22:03:00.000Z"
      }
    }
    """

  Scenario: Trying to make a request with no drivers around
    Given I send a POST request to "/users/driver_requests" with the following:
    """
    {
      "latitude" : "19.224500",
      "longitude" : "-103.741848"
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "status"  : "error",
      "error" : "no_drivers_around"
    }
    """

  Scenario: Trying to make a request twice
    Given I send a POST request to "/users/driver_requests" with the following:
    """
    {
      "latitude" : "19.264987",
      "longitude" : "-103.710863"
    }
    """
    Then the response status should be "201"
    And I send a POST request to "/users/driver_requests" with the following:
    """
    {
      "latitude" : "19.264987",
      "longitude" : "-103.710863"
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "status"  : "error",
      "error" : "multiple_driver_requests_not_allowed"
    }
    """
