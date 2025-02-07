# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountConferenceParticipant do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :call_sid,
    :label,
    :call_sid_to_coach,
    :coaching,
    :conference_sid,
    :date_created,
    :date_updated,
    :end_conference_on_exit,
    :muted,
    :hold,
    :start_conference_on_enter,
    :status,
    :queue_time,
    :uri
  ]

  @type t :: %__MODULE__{
    :account_sid => String.t | nil,
    :call_sid => String.t | nil,
    :label => String.t | nil,
    :call_sid_to_coach => String.t | nil,
    :coaching => boolean() | nil,
    :conference_sid => String.t | nil,
    :date_created => String.t | nil,
    :date_updated => String.t | nil,
    :end_conference_on_exit => boolean() | nil,
    :muted => boolean() | nil,
    :hold => boolean() | nil,
    :start_conference_on_enter => boolean() | nil,
    :status => Heckler.Adapters.Twilio.Model.ParticipantEnumStatus.t | nil,
    :queue_time => String.t | nil,
    :uri => String.t | nil
  }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:status, :struct, Heckler.Adapters.Twilio.Model.ParticipantEnumStatus)
  end
end

