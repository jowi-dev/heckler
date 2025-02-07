# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.RecordingTranscription do
  @moduledoc """
  API calls for all endpoints tagged `RecordingTranscription`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to delete.
  - `recording_sid` (String.t): The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to delete.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Transcription resource to delete.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_recording_transcription(Tesla.Env.client, String.t, String.t, String.t, keyword()) :: {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_recording_transcription(connection, account_sid, recording_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{recording_sid}/Transcriptions/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resource to fetch.
  - `recording_sid` (String.t): The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcription to fetch.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Transcription resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingTranscription.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_recording_transcription(Tesla.Env.client, String.t, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingTranscription.t()} | {:error, Tesla.Env.t()}
  def fetch_recording_transcription(connection, account_sid, recording_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{recording_sid}/Transcriptions/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountRecordingRecordingTranscription}
    ])
  end

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Transcription resources to read.
  - `recording_sid` (String.t): The SID of the [Recording](https://www.twilio.com/docs/voice/api/recording) that created the transcriptions to read.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListRecordingTranscriptionResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_recording_transcription(Tesla.Env.client, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.ListRecordingTranscriptionResponse.t()} | {:error, Tesla.Env.t()}
  def list_recording_transcription(connection, account_sid, recording_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Recordings/#{recording_sid}/Transcriptions.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListRecordingTranscriptionResponse}
    ])
  end
end
