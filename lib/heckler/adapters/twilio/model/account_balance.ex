# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountBalance do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :balance,
    :currency
  ]

  @type t :: %__MODULE__{
    :account_sid => String.t | nil,
    :balance => String.t | nil,
    :currency => String.t | nil
  }

  def decode(value) do
    value
  end
end

