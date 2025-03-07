# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountQueue do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :date_updated,
    :current_size,
    :friendly_name,
    :uri,
    :account_sid,
    :average_wait_time,
    :sid,
    :date_created,
    :max_size
  ]

  @type t :: %__MODULE__{
          :date_updated => String.t() | nil,
          :current_size => integer() | nil,
          :friendly_name => String.t() | nil,
          :uri => String.t() | nil,
          :account_sid => String.t() | nil,
          :average_wait_time => integer() | nil,
          :sid => String.t() | nil,
          :date_created => String.t() | nil,
          :max_size => integer() | nil
        }

  def decode(value) do
    value
  end
end
