# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountSipSipDomain do
  @moduledoc """
  
  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :api_version,
    :auth_type,
    :date_created,
    :date_updated,
    :domain_name,
    :friendly_name,
    :sid,
    :uri,
    :voice_fallback_method,
    :voice_fallback_url,
    :voice_method,
    :voice_status_callback_method,
    :voice_status_callback_url,
    :voice_url,
    :subresource_uris,
    :sip_registration,
    :emergency_calling_enabled,
    :secure,
    :byoc_trunk_sid,
    :emergency_caller_sid
  ]

  @type t :: %__MODULE__{
    :account_sid => String.t | nil,
    :api_version => String.t | nil,
    :auth_type => String.t | nil,
    :date_created => String.t | nil,
    :date_updated => String.t | nil,
    :domain_name => String.t | nil,
    :friendly_name => String.t | nil,
    :sid => String.t | nil,
    :uri => String.t | nil,
    :voice_fallback_method => String.t | nil,
    :voice_fallback_url => String.t | nil,
    :voice_method => String.t | nil,
    :voice_status_callback_method => String.t | nil,
    :voice_status_callback_url => String.t | nil,
    :voice_url => String.t | nil,
    :subresource_uris => map() | nil,
    :sip_registration => boolean() | nil,
    :emergency_calling_enabled => boolean() | nil,
    :secure => boolean() | nil,
    :byoc_trunk_sid => String.t | nil,
    :emergency_caller_sid => String.t | nil
  }

  def decode(value) do
    value
  end
end

