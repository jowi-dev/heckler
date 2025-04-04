# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountCallCallRecording do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :api_version,
    :call_sid,
    :conference_sid,
    :date_created,
    :date_updated,
    :start_time,
    :duration,
    :sid,
    :price,
    :uri,
    :encryption_details,
    :price_unit,
    :status,
    :channels,
    :source,
    :error_code,
    :track
  ]

  @type t :: %__MODULE__{
          :account_sid => String.t() | nil,
          :api_version => String.t() | nil,
          :call_sid => String.t() | nil,
          :conference_sid => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :start_time => String.t() | nil,
          :duration => String.t() | nil,
          :sid => String.t() | nil,
          :price => float() | nil,
          :uri => String.t() | nil,
          :encryption_details => any() | nil,
          :price_unit => String.t() | nil,
          :status => Heckler.Adapters.Twilio.Model.CallRecordingEnumStatus.t() | nil,
          :channels => integer() | nil,
          :source => Heckler.Adapters.Twilio.Model.CallRecordingEnumSource.t() | nil,
          :error_code => integer() | nil,
          :track => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :status,
      :struct,
      Heckler.Adapters.Twilio.Model.CallRecordingEnumStatus
    )
    |> Deserializer.deserialize(
      :source,
      :struct,
      Heckler.Adapters.Twilio.Model.CallRecordingEnumSource
    )
  end
end
