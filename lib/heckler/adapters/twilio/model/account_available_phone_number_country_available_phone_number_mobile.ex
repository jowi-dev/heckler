# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountAvailablePhoneNumberCountryAvailablePhoneNumberMobile do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :friendly_name,
    :phone_number,
    :lata,
    :locality,
    :rate_center,
    :latitude,
    :longitude,
    :region,
    :postal_code,
    :iso_country,
    :address_requirements,
    :beta,
    :capabilities
  ]

  @type t :: %__MODULE__{
          :friendly_name => String.t() | nil,
          :phone_number => String.t() | nil,
          :lata => String.t() | nil,
          :locality => String.t() | nil,
          :rate_center => String.t() | nil,
          :latitude => float() | nil,
          :longitude => float() | nil,
          :region => String.t() | nil,
          :postal_code => String.t() | nil,
          :iso_country => String.t() | nil,
          :address_requirements => String.t() | nil,
          :beta => boolean() | nil,
          :capabilities =>
            Heckler.Adapters.Twilio.Model.AccountAvailablePhoneNumberCountryAvailablePhoneNumberLocalCapabilities.t()
            | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :capabilities,
      :struct,
      Heckler.Adapters.Twilio.Model.AccountAvailablePhoneNumberCountryAvailablePhoneNumberLocalCapabilities
    )
  end
end
