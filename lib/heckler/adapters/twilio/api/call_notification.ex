# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.CallNotification do
  @moduledoc """
  API calls for all endpoints tagged `CallNotification`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resource to fetch.
  - `call_sid` (String.t): The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resource to fetch.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Call Notification resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountCallCallNotificationInstance.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_call_notification(Tesla.Env.client, String.t, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.AccountCallCallNotificationInstance.t()} | {:error, Tesla.Env.t()}
  def fetch_call_notification(connection, account_sid, call_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Calls/#{call_sid}/Notifications/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountCallCallNotificationInstance}
    ])
  end

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Call Notification resources to read.
  - `call_sid` (String.t): The [Call](https://www.twilio.com/docs/voice/api/call-resource) SID of the Call Notification resources to read.
  - `opts` (keyword): Optional parameters
    - `:Log` (integer()): Only read notifications of the specified log level. Can be:  `0` to read only ERROR notifications or `1` to read only WARNING notifications. By default, all notifications are read.
    - `:MessageDate` (Date.t): Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    - `:"MessageDate<"` (Date.t): Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    - `:"MessageDate>"` (Date.t): Only show notifications for the specified date, formatted as `YYYY-MM-DD`. You can also specify an inequality, such as `<=YYYY-MM-DD` for messages logged at or before midnight on a date, or `>=YYYY-MM-DD` for messages logged at or after midnight on a date.
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListCallNotificationResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_call_notification(Tesla.Env.client, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.ListCallNotificationResponse.t()} | {:error, Tesla.Env.t()}
  def list_call_notification(connection, account_sid, call_sid, opts \\ []) do
    optional_params = %{
      :Log => :query,
      :MessageDate => :query,
      :"MessageDate&lt;" => :query,
      :"MessageDate&gt;" => :query,
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Calls/#{call_sid}/Notifications.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListCallNotificationResponse}
    ])
  end
end
