# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountSipSipDomainSipAuthSipAuthCallsSipAuthCallsIpAccessControlListMapping do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :date_created,
    :date_updated,
    :friendly_name,
    :sid
  ]

  @type t :: %__MODULE__{
          :account_sid => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :friendly_name => String.t() | nil,
          :sid => String.t() | nil
        }

  def decode(value) do
    value
  end
end
