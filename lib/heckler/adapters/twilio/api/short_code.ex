# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.ShortCode do
  @moduledoc """
  API calls for all endpoints tagged `ShortCode`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Fetch an instance of a short code

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to fetch.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the ShortCode resource to fetch
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountShortCode.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_short_code(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountShortCode.t()} | {:error, Tesla.Env.t()}
  def fetch_short_code(connection, account_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/SMS/ShortCodes/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountShortCode}
    ])
  end

  @doc """
  Retrieve a list of short-codes belonging to the account used to make the request

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to read.
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): The string that identifies the ShortCode resources to read.
    - `:ShortCode` (String.t): Only show the ShortCode resources that match this pattern. You can specify partial numbers and use '*' as a wildcard for any digit.
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListShortCodeResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_short_code(Tesla.Env.client(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListShortCodeResponse.t()} | {:error, Tesla.Env.t()}
  def list_short_code(connection, account_sid, opts \\ []) do
    optional_params = %{
      :FriendlyName => :query,
      :ShortCode => :query,
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/SMS/ShortCodes.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListShortCodeResponse}
    ])
  end

  @doc """
  Update a short code with the following parameters

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the ShortCode resource(s) to update.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the ShortCode resource to update
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A descriptive string that you created to describe this resource. It can be up to 64 characters long. By default, the `FriendlyName` is the short code.
    - `:ApiVersion` (String.t): The API version to use to start a new TwiML session. Can be: `2010-04-01` or `2008-08-01`.
    - `:SmsUrl` (String.t): The URL we should call when receiving an incoming SMS message to this short code.
    - `:SmsMethod` (String.t): The HTTP method we should use when calling the `sms_url`. Can be: `GET` or `POST`.
    - `:SmsFallbackUrl` (String.t): The URL that we should call if an error occurs while retrieving or executing the TwiML from `sms_url`.
    - `:SmsFallbackMethod` (String.t): The HTTP method that we should use to call the `sms_fallback_url`. Can be: `GET` or `POST`.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountShortCode.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_short_code(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountShortCode.t()} | {:error, Tesla.Env.t()}
  def update_short_code(connection, account_sid, sid, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :ApiVersion => :form,
      :SmsUrl => :form,
      :SmsMethod => :form,
      :SmsFallbackUrl => :form,
      :SmsFallbackMethod => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/SMS/ShortCodes/#{sid}.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountShortCode}
    ])
  end
end
