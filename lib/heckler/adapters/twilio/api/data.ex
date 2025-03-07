# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Data do
  @moduledoc """
  API calls for all endpoints tagged `Data`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Fetch an instance of a result payload

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Recording AddOnResult Payload resource to fetch.
  - `reference_sid` (String.t): The SID of the recording to which the AddOnResult resource that contains the payload to fetch belongs.
  - `add_on_result_sid` (String.t): The SID of the AddOnResult to which the payload to fetch belongs.
  - `payload_sid` (String.t): The Twilio-provided string that uniquely identifies the Recording AddOnResult Payload resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_recording_add_on_result_payload_data(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          keyword()
        ) ::
          {:ok,
           Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResultRecordingAddOnResultPayloadRecordingAddOnResultPayloadData.t()}
          | {:error, Tesla.Env.t()}
  def fetch_recording_add_on_result_payload_data(
        connection,
        account_sid,
        reference_sid,
        add_on_result_sid,
        payload_sid,
        _opts \\ []
      ) do
    request =
      %{}
      |> method(:get)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/Recordings/#{reference_sid}/AddOnResults/#{add_on_result_sid}/Payloads/#{payload_sid}/Data.json"
      )
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {307,
       Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResultRecordingAddOnResultPayloadRecordingAddOnResultPayloadData}
    ])
  end
end
