# Taximático engine

This repository contains the code for the API published at [http://api.taximatico.mx/](http://api.taximatico.mx)

## Setup

Clone this repository and install the gems `bundle install`, then, create a file called `database.local.yml` at the `config/` folder with
your computer specific credentials and information for your local database.

## API Reference

### Registrations

#### POST http://api.taximatico.mx/users/registrations

Send the following information:

    {
      "user" : {
          "name"                  : "John Doe",
          "email"                 : "john_doe_15@example.com",
          "username"              : "John007",
          "phone_number"          : "3121111111",
          "profile_picture"       : <file object, jpeg, png, gif...>,
          "password"              : "supersecret",
          "password_confirmation" : "supersecret"
      }
    }

Sample response:

    {
      "user" : {
          "name"                  : "John Doe",
          "email"                 : "john_doe_15@example.com",
          "username"              : "John007",
          "phone_number"          : "3121111111",
          "profile_picture"       : { "profile_picture" : { "url" : "amazon_url" } },
          "authentication_token"  : "09niadh88asdjklf923",
          // timestamps
      }
    }


##### Error codes

* Unprocessable entity: `422`

Sample response:

    {
      "user" : { "errors" : "Validation failed: Email has already been taken" }
    }
