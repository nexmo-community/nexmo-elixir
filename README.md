# Nexmo Elixir Client Library

[![Build Status](https://travis-ci.org/nexmo-community/nexmo-elixir.svg?branch=master)](https://travis-ci.org/nexmo-community/nexmo-elixir)
 [![codecov](https://codecov.io/gh/nexmo-community/nexmo-elixir/branch/master/graph/badge.svg)](https://codecov.io/gh/nexmo-community/nexmo-elixir)

This is a work in progress Elixir client library for Nexmo. Functionality will be added for each Nexmo API service. Currently, this library supports:

* [Account API](#account-api)
* [Number Insight API](#number-insight-api)
* [SMS API](#sms-api)

## Installation

### Hex

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nexmo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nexmo, "~> 0.3.0"}
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

# Usage

## Account API

### Get Balance

```elixir
Nexmo.Account.get_balance
```
Docs: [https://developer.nexmo.com/api/account#getAccountBalance](https://developer.nexmo.com/api/account#getAccountBalance?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#get-account-balance)

### Top Up Balance

```elixir
Nexmo.Account.top_up(trx: "transaction_reference")
```
Docs: [https://developer.nexmo.com/api/account#topUpAccountBalance](https://developer.nexmo.com/api/account#topUpAccountBalance?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#topUp-account-balance)

### Change Account Settings

```elixir
Nexmo.Account.update(moCallBackUrl: "https://example.com/inbound", drCallBackUrl: "https://example.com/delivery")
```
Docs: [https://developer.nexmo.com/api/account#changeAccountSettings](https://developer.nexmo.com/api/account#changeAccountSettings?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#change-account-settings)

### Retrieve API Secrets

```elixir
Nexmo.Account.list_secrets
```
Docs: [https://developer.nexmo.com/api/account#retrieveAPISecrets](https://developer.nexmo.com/api/account#retrieveAPISecrets?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#retrieve-api-secrets)

### Create API Secret

```elixir
Nexmo.Account.create_secret(secret: "example-4PI-Secret")
```
Docs: [https://developer.nexmo.com/api/account#createAPISecret](https://developer.nexmo.com/api/account#createAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#create-api-secret)

### Retrieve one API Secret

```elixir
Nexmo.Account.get_secret(secret_id: "secret_id")
```
Docs: [https://developer.nexmo.com/api/account#retrieveAPISecret](https://developer.nexmo.com/api/account#retrieveAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#retrieve-api-secret)

### Revoke an API Secret

```elixir
Nexmo.Account.delete_secret(secret_id: "secret_id")
```
Docs: [https://developer.nexmo.com/api/account#revokeAPISecret](https://developer.nexmo.com/api/account#revokeAPISecret?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#revoke-api-secret)

## Number Insight API

### Basic Number Insight

```elixir
Nexmo.NumberInsight.basic(number: "447700900000")
```
Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightBasic](https://developer.nexmo.com/api/number-insight#getNumberInsightBasic?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightBasic)

### Standard Number Insight

```elixir
Nexmo.NumberInsight.standard(number: "447700900000")
```
Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightStandard](https://developer.nexmo.com/api/number-insight#getNumberInsightStandard?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightStandard)

### Advanced Number Insight

```elixir
Nexmo.NumberInsight.advanced(number: "447700900000")
```
Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightAdvanced](https://developer.nexmo.com/api/number-insight#getNumberInsightAdvanced?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightAdvanced)

### Advanced Number Insight Async

```elixir
Nexmo.NumberInsight.advanced_async(
  number: "447700900000", 
  callback: "https://example.com/callback"
)
```
Docs: [https://developer.nexmo.com/api/number-insight#getNumberInsightAsync](https://developer.nexmo.com/api/number-insight#getNumberInsightAsync?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#getNumberInsightAsync)

## SMS API

### Send an SMS

```elixir
Nexmo.Sms.send(
  from: YOUR_NUMBER, 
  to: RECIPIENT_NUMBER, 
  text: "Hello world
)
```

Docs: [https://developer.nexmo.com/api/sms#send-an-sms](https://developer.nexmo.com/api/sms?utm_source=DEV_REL&utm_medium=github&utm_campaign=elixir-client-library#send-an-sms)

# Testing

The tests for Nexmo Elixir can be found in `/test/`. Each API service has its own testing suite and can be found in `/test/#{name_of_service}`, for example the SMS tests can be found in `/test/sms`. To run the testing suite execute `mix test` from the command line.

# Appreciation

This project is built utilizing the wisdom and experience of earlier Nexmo Elixir projects, including from [KindyNowApp](https://github.com/KindyNowApp/ex_nexmo), [cbetta](https://github.com/cbetta/nexmo-elixir) and [adamrobbie](https://github.com/adamrobbie/exnexmo). Thank you all for your examples of interacting with Nexmo using Elixir!

# License

This project is licensed under the [MIT License](LICENSE).