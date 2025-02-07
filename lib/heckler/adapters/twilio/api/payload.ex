# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Payload do
  @moduledoc """
  API calls for all endpoints tagged `Payload`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Delete a payload from the result along with all associated Data

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to delete.
  - `reference_sid` (String.t): The SID of the recording to which the AddOnResult resource that contains the payloads to delete belongs.
  - `add_on_result_sid` (String.t): The SID of the AddOnResult to which the payloads to delete belongs.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to delete.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_recording_add_on_result_payload(Tesla.Env.client, String.t, String.t, String.t, String.t, keyword()) :: {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_recording_add_on_result_payload(connection, account_sid, reference_sid, add_on_result_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{reference_sid}/AddOnResults/#{add_on_result_sid}/Payloads/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  Fetch an instance of a result payload

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resource to fetch.
  - `reference_sid` (String.t): The SID of the recording to which the AddOnResult resource that contains the payload to fetch belongs.
  - `add_on_result_sid` (String.t): The SID of the AddOnResult to which the payload to fetch belongs.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResultRecordingAddOnResultPayload.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_recording_add_on_result_payload(Tesla.Env.client, String.t, String.t, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResultRecordingAddOnResultPayload.t()} | {:error, Tesla.Env.t()}
  def fetch_recording_add_on_result_payload(connection, account_sid, reference_sid, add_on_result_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{reference_sid}/AddOnResults/#{add_on_result_sid}/Payloads/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResultRecordingAddOnResultPayload}
    ])
  end

  @doc """
  Retrieve a list of payloads belonging to the AddOnResult

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resources to read.
  - `reference_sid` (String.t): The SID of the recording to which the AddOnResult resource that contains the payloads to read belongs.
  - `add_on_result_sid` (String.t): The SID of the AddOnResult to which the payloads to read belongs.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListRecordingAddOnResultPayloadResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_recording_add_on_result_payload(Tesla.Env.client, String.t, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.ListRecordingAddOnResultPayloadResponse.t()} | {:error, Tesla.Env.t()}
  def list_recording_add_on_result_payload(connection, account_sid, reference_sid, add_on_result_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{reference_sid}/AddOnResults/#{add_on_result_sid}/Payloads.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListRecordingAddOnResultPayloadResponse}
    ])
  end
end
