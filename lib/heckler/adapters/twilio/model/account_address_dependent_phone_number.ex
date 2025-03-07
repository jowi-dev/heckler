# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountAddressDependentPhoneNumber do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :sid,
    :account_sid,
    :friendly_name,
    :phone_number,
    :voice_url,
    :voice_method,
    :voice_fallback_method,
    :voice_fallback_url,
    :voice_caller_id_lookup,
    :date_created,
    :date_updated,
    :sms_fallback_method,
    :sms_fallback_url,
    :sms_method,
    :sms_url,
    :address_requirements,
    :capabilities,
    :status_callback,
    :status_callback_method,
    :api_version,
    :sms_application_sid,
    :voice_application_sid,
    :trunk_sid,
    :emergency_status,
    :emergency_address_sid,
    :uri
  ]

  @type t :: %__MODULE__{
          :sid => String.t() | nil,
          :account_sid => String.t() | nil,
          :friendly_name => String.t() | nil,
          :phone_number => String.t() | nil,
          :voice_url => String.t() | nil,
          :voice_method => String.t() | nil,
          :voice_fallback_method => String.t() | nil,
          :voice_fallback_url => String.t() | nil,
          :voice_caller_id_lookup => boolean() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :sms_fallback_method => String.t() | nil,
          :sms_fallback_url => String.t() | nil,
          :sms_method => String.t() | nil,
          :sms_url => String.t() | nil,
          :address_requirements =>
            Heckler.Adapters.Twilio.Model.DependentPhoneNumberEnumAddressRequirement.t() | nil,
          :capabilities => any() | nil,
          :status_callback => String.t() | nil,
          :status_callback_method => String.t() | nil,
          :api_version => String.t() | nil,
          :sms_application_sid => String.t() | nil,
          :voice_application_sid => String.t() | nil,
          :trunk_sid => String.t() | nil,
          :emergency_status =>
            Heckler.Adapters.Twilio.Model.DependentPhoneNumberEnumEmergencyStatus.t() | nil,
          :emergency_address_sid => String.t() | nil,
          :uri => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :address_requirements,
      :struct,
      Heckler.Adapters.Twilio.Model.DependentPhoneNumberEnumAddressRequirement
    )
    |> Deserializer.deserialize(
      :emergency_status,
      :struct,
      Heckler.Adapters.Twilio.Model.DependentPhoneNumberEnumEmergencyStatus
    )
  end
end
