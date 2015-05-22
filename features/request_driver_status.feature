Feature: Request driver status
  As a user
  I should be able to see my request status
  in order to know if a driver has accepted it

  Background:
    Given I send and accept JSON
    And the time is 2015-05-04 22:00
    And the following drivers exist:
      | name              | taxi_number | latitude  | longitude    |
      | Juan Perez        | 5           | 19.264997 | -103.7108419 |
      | John Doe          | 22          | 19.265189 | -103.713567  |
      | Maria Guadalupe   | 10          | 19.269585 | -103.716614  |
    And a user with phone number "+523121125642" exists
    And his authentication token is "foobar"
    And I have requested a driver from latitude "19.264987" and longitude "-103.710863"
    Given I set the request with the header "X-AUTHENTICATION-TOKEN" as "foobar"

  Scenario: Waiting a driver for respond to my request
    And I send a GET request to "/users/driver_requests/1" with the following:
    """
    """
    Then the response status should be "200"
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

  Scenario: When a driver responds to the request
    Given a driver with taxi number "5" responds to my request with id "1"
    And I send a GET request to "/users/driver_requests/1" with the following:
    """
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status"  : "ok",
      "driver_request" : {
        "id" : 1,
        "user_id" : 1,
        "driver_id" : 1,
        "status" : "in_progress",
        "created_at" : "2015-05-04T22:00:00.000Z",
        "expires_at" : "2015-05-04T22:03:00.000Z"
      }
    }
    """
    Then the status from the driver "5" should be "busy"
