# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.AccountTokenIceServersInner do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :credential,
    :username,
    :url,
    :urls
  ]

  @type t :: %__MODULE__{
          :credential => String.t() | nil,
          :username => String.t() | nil,
          :url => String.t() | nil,
          :urls => String.t() | nil
        }

  def decode(value) do
    value
  end
end
