Feature: Registrations
  As a User
  I should be able to register to the service
  in order to start using it

  Background:
    Given I send and accept JSON


  @twilio-sms
  Scenario: Sending your phone number successfully
    Given I send a POST request to "/users/registrations" with the following:
    """
    {
      "user" : {
        "phone_number" : "+523121125642"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "status" : "ok",
      "message" : "verification_code_sent"
    }
    """

  @twilio-sms
  Scenario: Sending the code as a returing user
    Given a user with phone number "+523121125642" exists
    And I send a POST request to "/users/registrations" with the following:
    """
    {
      "user" : {
        "phone_number" : "+523121125642"
      }
    }
    """
    Then the response status should be "201"
    And the JSON response should be:
    """
    {
      "status" : "ok",
      "message" : "verification_code_sent"
    }
    """

  Scenario: Sending your phone number unsuccessfully
    Given I send a POST request to "/users/registrations" with the following:
    """
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "status" : "error",
      "errors" : ["Phone number can't be blank", "Phone number is invalid" ]
    }
    """
