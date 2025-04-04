# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountTranscription do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :api_version,
    :date_created,
    :date_updated,
    :duration,
    :price,
    :price_unit,
    :recording_sid,
    :sid,
    :status,
    :transcription_text,
    :type,
    :uri
  ]

  @type t :: %__MODULE__{
          :account_sid => String.t() | nil,
          :api_version => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :duration => String.t() | nil,
          :price => float() | nil,
          :price_unit => String.t() | nil,
          :recording_sid => String.t() | nil,
          :sid => String.t() | nil,
          :status => Heckler.Adapters.Twilio.Model.TranscriptionEnumStatus.t() | nil,
          :transcription_text => String.t() | nil,
          :type => String.t() | nil,
          :uri => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :status,
      :struct,
      Heckler.Adapters.Twilio.Model.TranscriptionEnumStatus
    )
  end
end
