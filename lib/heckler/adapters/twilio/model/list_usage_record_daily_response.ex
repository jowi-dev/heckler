# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.ListUsageRecordDailyResponse do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :usage_records,
    :end,
    :first_page_uri,
    :next_page_uri,
    :page,
    :page_size,
    :previous_page_uri,
    :start,
    :uri
  ]

  @type t :: %__MODULE__{
          :usage_records =>
            [Heckler.Adapters.Twilio.Model.AccountUsageUsageRecordUsageRecordDaily.t()] | nil,
          :end => integer() | nil,
          :first_page_uri => String.t() | nil,
          :next_page_uri => String.t() | nil,
          :page => integer() | nil,
          :page_size => integer() | nil,
          :previous_page_uri => String.t() | nil,
          :start => integer() | nil,
          :uri => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :usage_records,
      :list,
      Heckler.Adapters.Twilio.Model.AccountUsageUsageRecordUsageRecordDaily
    )
  end
end
