Feature: Registrations
  As a User
  I should be able to register to the service
  in order to start using it

  Background:
    Given I send and accept JSON

  Scenario: Registering successfully
    Given I send a multipart POST request to "/users/registrations" with:
      | Name                        | Content          | Filename            | Type       |
      | user[name]                  | Antonio Chavez   |                     |            |
      | user[email]                 | cavjzz@gmail.com |                     |            |
      | user[username]              | TheNaoX          |                     |            |
      | user[phone_number]          | 3121111111       |                     |            |
      | user[profile_picture]       |                  | profile_picture.jpg | image/jpeg |
      | user[password]              | supersecret      |                     |            |
      | user[password_confirmation] | supersecret      |                     |            |
    Then the response status should be "201"
    And the JSON response should have "$..name" with the text "Antonio Chavez"
    And the JSON response should have "$..email" with the text "cavjzz@gmail.com"
    And the JSON response should have "$..username" with the text "TheNaoX"
    And the JSON response should have "$..phone_number" with the text "3121111111"
    And the JSON response should have "$..profile_picture" with a length of 2
    And the JSON response should have "$..authentication_token" with a length of 1

  Scenario: Registering unsuccessfully
    Given I send a POST request to "/users/registrations" with the following:
    """
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "user" : {
        "errors" : "Validation failed: Email can't be blank, Password can't be blank, Phone number can't be blank"
      }
    }
    """

  Scenario: Try to register twice
    Given I send a multipart POST request to "/users/registrations" with:
      | Name                        | Content          | Filename            | Type       |
      | user[name]                  | Antonio Chavez   |                     |            |
      | user[email]                 | cavjzz@gmail.com |                     |            |
      | user[username]              | TheNaoX          |                     |            |
      | user[profile_picture]       |                  | profile_picture.jpg | image/jpeg |
      | user[phone_number]          | 3121111111       |                     |            |
      | user[password]              | supersecret      |                     |            |
      | user[password_confirmation] | supersecret      |                     |            |
    Then the response status should be "201"
    Given I send a multipart POST request to "/users/registrations" with:
      | Name                        | Content          | Filename            | Type       |
      | user[name]                  | Antonio Chavez   |                     |            |
      | user[email]                 | cavjzz@gmail.com |                     |            |
      | user[username]              | TheNaoX          |                     |            |
      | user[phone_number]          | 3121111111       |                     |            |
      | user[profile_picture]       |                  | profile_picture.jpg | image/jpeg |
      | user[password]              | supersecret      |                     |            |
      | user[password_confirmation] | supersecret      |                     |            |
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "user" : { "errors" : "Validation failed: Email has already been taken" }
    }
    """
