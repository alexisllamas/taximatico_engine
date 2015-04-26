Feature: Search drivers
  As a user
  I should be able to get a list of drivers near me
  in order to know if I can get a cab

  Background:
    Given I send and accept JSON
    And the following drivers exist:
      | name              | taxi_number | latitude  | longitude    |
      | Juan Perez        | 5           | 19.264997 | -103.7108419 |
      | John Doe          | 22          | 19.265189 | -103.713567  |
      | Maria Guadalupe   | 10          | 19.269585 | -103.716614  |

  Scenario: Search drivers succesfully
    Given a user with phone number "+523121125642" exists
    And his coordinates are latitude "19.264987" longitude "-103.710863"
    And his authentication token is "foobar"
    And I send a GET request to "/users/drivers" with the following:
    """
    {
      "authentication_token" : "foobar",
      "latitude" : "19.264987",
      "longitude" : "-103.710863"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status"  : "ok",
      "drivers" : [
        {
          "id" : 1,
          "name" : "Juan Perez",
          "taxi_number" : 5,
          "latitude" : 19.264997,
          "longitude" : -103.7108419
        },
        {
          "id" : 2,
          "name" : "John Doe",
          "taxi_number" : 22,
          "latitude" : 19.265189,
          "longitude" : -103.713567
        },
        {
          "id" : 3,
          "name" : "Maria Guadalupe",
          "taxi_number" : 10,
          "latitude" : 19.269585,
          "longitude" : -103.716614
        }
      ]
    }
    """

  Scenario: Search drivers succesfully with no drivers around
    Given a user with phone number "+523121125642" exists
    And his coordinates are latitude "19.224500" longitude "-103.741848"
    And his authentication token is "foobar"
    And I send a GET request to "/users/drivers" with the following:
    """
    {
      "authentication_token" : "foobar",
      "latitude" : "19.224500",
      "longitude" : "-103.741848"
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status"  : "ok",
      "drivers" : [ ]
    }
    """

  Scenario: Search drivers unsuccesfully
    Given a user with phone number "+523121125642" exists
    And his coordinates are latitude "19.224500" longitude "-103.741848"
    And his authentication token is "foobar"
    And I send a GET request to "/users/drivers" with the following:
    """
    {
      "latitude" : "19.224500",
      "longitude" : "-103.741848"
    }
    """
    Then the response status should be "401"
    And the JSON response should be:
    """
    {
      "status" : "error",
      "error" : "auth_token_not_present_or_invalid"
    }
    """
