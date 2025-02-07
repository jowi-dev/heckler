# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOnIncomingPhoneNumberAssignedAddOnExtension do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :sid,
    :account_sid,
    :resource_sid,
    :assigned_add_on_sid,
    :friendly_name,
    :product_name,
    :unique_name,
    :uri,
    :enabled
  ]

  @type t :: %__MODULE__{
    :sid => String.t | nil,
    :account_sid => String.t | nil,
    :resource_sid => String.t | nil,
    :assigned_add_on_sid => String.t | nil,
    :friendly_name => String.t | nil,
    :product_name => String.t | nil,
    :unique_name => String.t | nil,
    :uri => String.t | nil,
    :enabled => boolean() | nil
  }

  def decode(value) do
    value
  end
end

