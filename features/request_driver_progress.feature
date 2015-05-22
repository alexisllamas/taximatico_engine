Feature: Request driver progress
  As a nuser
  I should be able to see my request status progress
  in order to see the driver's route to my place

  Background:
    Given I send and accept JSON
    And the time is 2015-05-04 22:00
    And the following drivers exist:
      | name              | taxi_number | latitude  | longitude    |
      | Juan Perez        | 5           | 19.264997 | -103.7108419 |
    And a user with phone number "+523121125642" exists
    And his authentication token is "foobar"
    And I set the request with the header "X-AUTHENTICATION-TOKEN" as "foobar"
    And I have requested a driver from latitude "19.264987" and longitude "-103.710863"
    And a driver with taxi number "5" responds to my request with id "1"

  Scenario: Getting the driver's progress
    Given I send a GET request to "/users/driver_requests/1/progress" with the following:
    """
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status" : "ok",
      "progress" : [
        {
          "id" : 1,
          "location" : {
            "latitude" : 19.264997,
            "longitude" : -103.7108419
          },
          "created_at" : "2015-05-04T22:00:00.000Z"
        }
      ]
    }
    """

  Scenario: Driver moves ahead on location
    Given the driver "5" is now at latitude "19.264020" and "-103.711421"
    And I send a GET request to "/users/driver_requests/1/progress" with the following:
    """
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status" : "ok",
      "progress" : [
        {
          "id" : 1,
          "location" : {
            "latitude" : 19.264997,
            "longitude" : -103.7108419
          },
          "created_at" : "2015-05-04T22:00:00.000Z"
        },
        {
          "id" : 2,
          "location" : {
            "latitude" : 19.264020,
            "longitude" : -103.711421
          },
          "created_at" : "2015-05-04T22:00:00.000Z"
        }
      ]
    }
    """
