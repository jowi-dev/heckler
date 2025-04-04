# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountMessage do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :body,
    :num_segments,
    :direction,
    :from,
    :to,
    :date_updated,
    :price,
    :error_message,
    :uri,
    :account_sid,
    :num_media,
    :status,
    :messaging_service_sid,
    :sid,
    :date_sent,
    :date_created,
    :error_code,
    :price_unit,
    :api_version,
    :subresource_uris
  ]

  @type t :: %__MODULE__{
          :body => String.t() | nil,
          :num_segments => String.t() | nil,
          :direction => Heckler.Adapters.Twilio.Model.MessageEnumDirection.t() | nil,
          :from => String.t() | nil,
          :to => String.t() | nil,
          :date_updated => String.t() | nil,
          :price => String.t() | nil,
          :error_message => String.t() | nil,
          :uri => String.t() | nil,
          :account_sid => String.t() | nil,
          :num_media => String.t() | nil,
          :status => Heckler.Adapters.Twilio.Model.MessageEnumStatus.t() | nil,
          :messaging_service_sid => String.t() | nil,
          :sid => String.t() | nil,
          :date_sent => String.t() | nil,
          :date_created => String.t() | nil,
          :error_code => integer() | nil,
          :price_unit => String.t() | nil,
          :api_version => String.t() | nil,
          :subresource_uris => map() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :direction,
      :struct,
      Heckler.Adapters.Twilio.Model.MessageEnumDirection
    )
    |> Deserializer.deserialize(:status, :struct, Heckler.Adapters.Twilio.Model.MessageEnumStatus)
  end
end
