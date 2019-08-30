# Nexmo Elixir Client Library

[![Build Status](https://travis-ci.org/nexmo-community/nexmo-elixir.svg?branch=master)](https://travis-ci.org/nexmo-community/nexmo-elixir)
 [![codecov](https://codecov.io/gh/nexmo-community/nexmo-elixir/branch/master/graph/badge.svg)](https://codecov.io/gh/nexmo-community/nexmo-elixir)

This is a work in progress Elixir client library for Nexmo. Functionality will be added for each Nexmo API service. Currently, this library supports:

* [SMS API](#sms-api)

## Installation

### Hex

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nexmo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nexmo, "~> 0.1.0"}
  ]
end
```

### Environment Variables

The client library requires environment variables to be supplied in order to enable its functionality. You can find a [sample .env file](/.env.sample) in the root directory of the project. You need to supply your API credentials and the host names for the API endpoints in the `.env` file.

Your Nexmo API credentials:
* `NEXMO_API_KEY`
* `NEXMO_API_SECRET`

API host names:
* `SMS_API_ENDPOINT="https://rest.nexmo.com/sms/json"`
* `ACCOUNT_API_ENDPOINT="https://rest.nexmo.com/account"`

# Usage

## SMS API

### Send an SMS

```elixir
Nexmo.Sms.send(YOUR_NUMBER, RECIPIENT_NUMBER, "Hello world")
```

Docs: [https://developer.nexmo.com/api/sms#send-an-sms](https://developer.nexmo.com/api/sms?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#send-an-sms)

## Account API

### Get Balance

```elixir
Nexmo.Account.get_balance
```

Docs: [https://developer.nexmo.com/api/account#getAccountBalance](https://developer.nexmo.com/api/account#getAccountBalance?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#get-account-balance)

# Testing

The tests for Nexmo Elixir can be found in `/test/`. Each API service has its own testing suite and can be found in `/test/#{name_of_service}`, for example the SMS tests can be found in `/test/sms`. To run the testing suite execute `mix test` from the command line.

# Appreciation

This project is built utilizing the wisdom and experience of earlier Nexmo Elixir projects, including from [KindyNowApp](https://github.com/KindyNowApp/ex_nexmo), [cbetta](https://github.com/cbetta/nexmo-elixir) and [adamrobbie](https://github.com/adamrobbie/exnexmo). Thank you all for your examples of interacting with Nexmo using Elixir!

# License

This project is licensed under the [MIT License](LICENSE).