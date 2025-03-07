# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Feedback do
  @moduledoc """
  API calls for all endpoints tagged `Feedback`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create Message Feedback to confirm a tracked user action was performed by the recipient of the associated Message

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) associated with the Message resource for which to create MessageFeedback.
  - `message_sid` (String.t): The SID of the Message resource for which to create MessageFeedback.
  - `opts` (keyword): Optional parameters
    - `:Outcome` (Heckler.Adapters.Twilio.Model.MessageFeedbackEnumOutcome.t): 

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountMessageMessageFeedback.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_message_feedback(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountMessageMessageFeedback.t()}
          | {:error, Tesla.Env.t()}
  def create_message_feedback(connection, account_sid, message_sid, opts \\ []) do
    optional_params = %{
      :Outcome => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/Messages/#{message_sid}/Feedback.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, Heckler.Adapters.Twilio.Model.AccountMessageMessageFeedback}
    ])
  end
end
