# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountUsageUsageRecord do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :api_version,
    :as_of,
    :category,
    :count,
    :count_unit,
    :description,
    :end_date,
    :price,
    :price_unit,
    :start_date,
    :subresource_uris,
    :uri,
    :usage,
    :usage_unit
  ]

  @type t :: %__MODULE__{
    :account_sid => String.t | nil,
    :api_version => String.t | nil,
    :as_of => String.t | nil,
    :category => Heckler.Adapters.Twilio.Model.UsageRecordEnumCategory.t | nil,
    :count => String.t | nil,
    :count_unit => String.t | nil,
    :description => String.t | nil,
    :end_date => Date.t | nil,
    :price => float() | nil,
    :price_unit => String.t | nil,
    :start_date => Date.t | nil,
    :subresource_uris => map() | nil,
    :uri => String.t | nil,
    :usage => String.t | nil,
    :usage_unit => String.t | nil
  }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:category, :struct, Heckler.Adapters.Twilio.Model.UsageRecordEnumCategory)
     |> Deserializer.deserialize(:end_date, :date, nil)
     |> Deserializer.deserialize(:start_date, :date, nil)
  end
end

