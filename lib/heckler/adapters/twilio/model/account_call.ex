# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountCall do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :sid,
    :date_created,
    :date_updated,
    :parent_call_sid,
    :account_sid,
    :to,
    :to_formatted,
    :from,
    :from_formatted,
    :phone_number_sid,
    :status,
    :start_time,
    :end_time,
    :duration,
    :price,
    :price_unit,
    :direction,
    :answered_by,
    :api_version,
    :forwarded_from,
    :group_sid,
    :caller_name,
    :queue_time,
    :trunk_sid,
    :uri,
    :subresource_uris
  ]

  @type t :: %__MODULE__{
          :sid => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :parent_call_sid => String.t() | nil,
          :account_sid => String.t() | nil,
          :to => String.t() | nil,
          :to_formatted => String.t() | nil,
          :from => String.t() | nil,
          :from_formatted => String.t() | nil,
          :phone_number_sid => String.t() | nil,
          :status => Heckler.Adapters.Twilio.Model.CallEnumStatus.t() | nil,
          :start_time => String.t() | nil,
          :end_time => String.t() | nil,
          :duration => String.t() | nil,
          :price => String.t() | nil,
          :price_unit => String.t() | nil,
          :direction => String.t() | nil,
          :answered_by => String.t() | nil,
          :api_version => String.t() | nil,
          :forwarded_from => String.t() | nil,
          :group_sid => String.t() | nil,
          :caller_name => String.t() | nil,
          :queue_time => String.t() | nil,
          :trunk_sid => String.t() | nil,
          :uri => String.t() | nil,
          :subresource_uris => map() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(:status, :struct, Heckler.Adapters.Twilio.Model.CallEnumStatus)
  end
end
