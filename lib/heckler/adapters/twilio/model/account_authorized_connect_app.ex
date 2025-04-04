# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountAuthorizedConnectApp do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :connect_app_company_name,
    :connect_app_description,
    :connect_app_friendly_name,
    :connect_app_homepage_url,
    :connect_app_sid,
    :permissions,
    :uri
  ]

  @type t :: %__MODULE__{
          :account_sid => String.t() | nil,
          :connect_app_company_name => String.t() | nil,
          :connect_app_description => String.t() | nil,
          :connect_app_friendly_name => String.t() | nil,
          :connect_app_homepage_url => String.t() | nil,
          :connect_app_sid => String.t() | nil,
          :permissions =>
            [Heckler.Adapters.Twilio.Model.AuthorizedConnectAppEnumPermission.t()] | nil,
          :uri => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :permissions,
      :list,
      Heckler.Adapters.Twilio.Model.AuthorizedConnectAppEnumPermission
    )
  end
end
