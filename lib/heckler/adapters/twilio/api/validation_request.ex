# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.ValidationRequest do
  @moduledoc """
  API calls for all endpoints tagged `ValidationRequest`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """


  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) responsible for the new caller ID resource.
  - `phone_number` (String.t): The phone number to verify in [E.164](https://www.twilio.com/docs/glossary/what-e164) format, which consists of a + followed by the country code and subscriber number.
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A descriptive string that you create to describe the new caller ID resource. It can be up to 64 characters long. The default value is a formatted version of the phone number.
    - `:CallDelay` (integer()): The number of seconds to delay before initiating the verification call. Can be an integer between `0` and `60`, inclusive. The default is `0`.
    - `:Extension` (String.t): The digits to dial after connecting the verification call.
    - `:StatusCallback` (String.t): The URL we should call using the `status_callback_method` to send status information about the verification process to your application.
    - `:StatusCallbackMethod` (String.t): The HTTP method we should use to call `status_callback`. Can be: `GET` or `POST`, and the default is `POST`.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountValidationRequest.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_validation_request(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountValidationRequest.t()}
          | {:error, Tesla.Env.t()}
  def create_validation_request(connection, account_sid, phone_number, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :CallDelay => :form,
      :Extension => :form,
      :StatusCallback => :form,
      :StatusCallbackMethod => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/OutgoingCallerIds.json")
      |> add_param(:form, :PhoneNumber, phone_number)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountValidationRequest}
    ])
  end
end
