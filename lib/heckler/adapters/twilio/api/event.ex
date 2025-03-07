# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Event do
  @moduledoc """
  API calls for all endpoints tagged `Event`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Retrieve a list of all events for a call.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique SID identifier of the Account.
  - `call_sid` (String.t): The unique SID identifier of the Call.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListCallEventResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_call_event(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListCallEventResponse.t()} | {:error, Tesla.Env.t()}
  def list_call_event(connection, account_sid, call_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Calls/#{call_sid}/Events.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListCallEventResponse}
    ])
  end
end
