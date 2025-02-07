# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberMobile do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :address_sid,
    :address_requirements,
    :api_version,
    :beta,
    :capabilities,
    :date_created,
    :date_updated,
    :friendly_name,
    :identity_sid,
    :phone_number,
    :origin,
    :sid,
    :sms_application_sid,
    :sms_fallback_method,
    :sms_fallback_url,
    :sms_method,
    :sms_url,
    :status_callback,
    :status_callback_method,
    :trunk_sid,
    :uri,
    :voice_receive_mode,
    :voice_application_sid,
    :voice_caller_id_lookup,
    :voice_fallback_method,
    :voice_fallback_url,
    :voice_method,
    :voice_url,
    :emergency_status,
    :emergency_address_sid,
    :emergency_address_status,
    :bundle_sid,
    :status
  ]

  @type t :: %__MODULE__{
    :account_sid => String.t | nil,
    :address_sid => String.t | nil,
    :address_requirements => Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumAddressRequirement.t | nil,
    :api_version => String.t | nil,
    :beta => boolean() | nil,
    :capabilities => Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberCapabilities.t | nil,
    :date_created => String.t | nil,
    :date_updated => String.t | nil,
    :friendly_name => String.t | nil,
    :identity_sid => String.t | nil,
    :phone_number => String.t | nil,
    :origin => String.t | nil,
    :sid => String.t | nil,
    :sms_application_sid => String.t | nil,
    :sms_fallback_method => String.t | nil,
    :sms_fallback_url => String.t | nil,
    :sms_method => String.t | nil,
    :sms_url => String.t | nil,
    :status_callback => String.t | nil,
    :status_callback_method => String.t | nil,
    :trunk_sid => String.t | nil,
    :uri => String.t | nil,
    :voice_receive_mode => Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumVoiceReceiveMode.t | nil,
    :voice_application_sid => String.t | nil,
    :voice_caller_id_lookup => boolean() | nil,
    :voice_fallback_method => String.t | nil,
    :voice_fallback_url => String.t | nil,
    :voice_method => String.t | nil,
    :voice_url => String.t | nil,
    :emergency_status => Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumEmergencyStatus.t | nil,
    :emergency_address_sid => String.t | nil,
    :emergency_address_status => Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumEmergencyAddressStatus.t | nil,
    :bundle_sid => String.t | nil,
    :status => String.t | nil
  }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
     |> Deserializer.deserialize(:address_requirements, :struct, Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumAddressRequirement)
     |> Deserializer.deserialize(:capabilities, :struct, Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberCapabilities)
     |> Deserializer.deserialize(:voice_receive_mode, :struct, Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumVoiceReceiveMode)
     |> Deserializer.deserialize(:emergency_status, :struct, Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumEmergencyStatus)
     |> Deserializer.deserialize(:emergency_address_status, :struct, Heckler.Adapters.Twilio.Model.IncomingPhoneNumberMobileEnumEmergencyAddressStatus)
  end
end

