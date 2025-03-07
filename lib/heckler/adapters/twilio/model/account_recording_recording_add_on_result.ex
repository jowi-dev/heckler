# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountRecordingRecordingAddOnResult do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :sid,
    :account_sid,
    :status,
    :add_on_sid,
    :add_on_configuration_sid,
    :date_created,
    :date_updated,
    :date_completed,
    :reference_sid,
    :subresource_uris
  ]

  @type t :: %__MODULE__{
          :sid => String.t() | nil,
          :account_sid => String.t() | nil,
          :status => Heckler.Adapters.Twilio.Model.RecordingAddOnResultEnumStatus.t() | nil,
          :add_on_sid => String.t() | nil,
          :add_on_configuration_sid => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :date_completed => String.t() | nil,
          :reference_sid => String.t() | nil,
          :subresource_uris => map() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :status,
      :struct,
      Heckler.Adapters.Twilio.Model.RecordingAddOnResultEnumStatus
    )
  end
end
