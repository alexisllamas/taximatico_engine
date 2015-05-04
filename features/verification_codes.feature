Feature: Verification codes
  As a User
  I should be able to validate my verification code
  in order to get the authentication token:

  Background:
    Given I send and accept JSON

  @twilio-sms
  Scenario: Successfully verifying the code
    Given a user with phone number "+523121125642" and verification code "123456" exist
    And his authentication token is "authentication_token_123"
    And I send a POST request to "/users/verification_codes/check" with the following:
    """
    {
      "verification_code" : {
        "code" : "123456"
      }
    }
    """
    Then the response status should be "200"
    And the JSON response should be:
    """
    {
      "status"               : "ok",
      "authentication_token" : "authentication_token_123"
    }
    """

  @twilio-sms
  Scenario: Unsuccessfully verifying the code
    Given a user with phone number "+523121125642" and verification code "123456" exist
    And I send a POST request to "/users/verification_codes/check" with the following:
    """
    {
      "verification_code" : {
        "code" : "not_the_code"
      }
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "status" : "error",
      "error"  : "verification_code_not_exists"
    }
    """

  @twilio-sms
  Scenario: Trying to verify code twice
    Given a user with phone number "+523121125642" and verification code "123456" exist
    And I send a POST request to "/users/verification_codes/check" with the following:
    """
    {
      "verification_code" : {
        "code" : "123456"
      }
    }
    """
    Then the response status should be "200"
    And I send a POST request to "/users/verification_codes/check" with the following:
    """
    {
      "verification_code" : {
        "code" : "123456"
      }
    }
    """
    Then the response status should be "422"
    And the JSON response should be:
    """
    {
      "status" : "error",
      "error"  : "verification_code_not_exists"
    }
    """
