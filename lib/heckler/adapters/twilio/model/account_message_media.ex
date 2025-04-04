# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountMessageMedia do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :account_sid,
    :content_type,
    :date_created,
    :date_updated,
    :parent_sid,
    :sid,
    :uri
  ]

  @type t :: %__MODULE__{
          :account_sid => String.t() | nil,
          :content_type => String.t() | nil,
          :date_created => String.t() | nil,
          :date_updated => String.t() | nil,
          :parent_sid => String.t() | nil,
          :sid => String.t() | nil,
          :uri => String.t() | nil
        }

  def decode(value) do
    value
  end
end
