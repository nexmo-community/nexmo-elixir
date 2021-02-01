# Nexmo Elixir Client Library

[![Build Status](https://travis-ci.org/nexmo-community/nexmo-elixir.svg?branch=main)](https://travis-ci.org/nexmo-community/nexmo-elixir)
 [![codecov](https://codecov.io/gh/nexmo-community/nexmo-elixir/branch/master/graph/badge.svg)](https://codecov.io/gh/nexmo-community/nexmo-elixir)

This is a work in progress Elixir client library for Nexmo. Functionality will be added for each Nexmo API service. Currently, this library supports the Account, Applications, Number Insight and SMS Nexmo APIs.

* [Installation](#installation)
  * [Hex](#hex)
  * [Environment Variables](#environment-variables)
* [Documentation](#documentation)
* [Testing](#testing)
* [License](#license)

## Installation

### Hex

The [Hex package](https://hex.pm/packages/nexmo_elixir) can be installed by adding `nexmo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nexmo, "~> 0.4.0", hex: :nexmo_elixir}
  ]
end
```

### Environment Variables

The client library requires environment variables to be supplied in order to enable its functionality. You can find a [sample .env file](/.env.sample) in the root directory of the project. You need to supply your API credentials and the host names for the API endpoints in the `.env` file.

Your Nexmo API credentials:
* `NEXMO_API_KEY`
* `NEXMO_API_SECRET`

API host names:
* `ACCOUNT_API_ENDPOINT="https://rest.nexmo.com/account"`
* `NUMBER_INSIGHT_API_ENDPOINT="https://api.nexmo.com/ni"`
* `SECRETS_API_ENDPOINT="https://api.nexmo.com/accounts"`
* `SMS_API_ENDPOINT="https://rest.nexmo.com/sms/json"`

# Documentation

* Nexmo Elixir documentation: [https://hexdocs.pm/nexmo_elixir/api-reference.html](https://hexdocs.pm/nexmo_elixir/api-reference.html)
* Nexmo API reference: [https://developer.nexmo.com/api](https://developer.nexmo.com/api)

# Testing

The tests for Nexmo Elixir can be found in `/test/`. Each API service has its own testing suite and can be found in `/test/#{name_of_service}`, for example the SMS tests can be found in `/test/sms`. To run the testing suite execute `mix test` from the command line.

# Appreciation

This project is built utilizing the wisdom and experience of earlier Nexmo Elixir projects, including from [KindyNowApp](https://github.com/KindyNowApp/ex_nexmo), [cbetta](https://github.com/cbetta/nexmo-elixir) and [adamrobbie](https://github.com/adamrobbie/exnexmo). Thank you all for your examples of interacting with Nexmo using Elixir!

# License

This project is licensed under the [MIT License](LICENSE).