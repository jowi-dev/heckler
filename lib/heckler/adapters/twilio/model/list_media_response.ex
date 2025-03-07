# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Model.ListMediaResponse do
  @moduledoc """

  """

  @derive Jason.Encoder
  defstruct [
    :media_list,
    :end,
    :first_page_uri,
    :next_page_uri,
    :page,
    :page_size,
    :previous_page_uri,
    :start,
    :uri
  ]

  @type t :: %__MODULE__{
          :media_list => [Heckler.Adapters.Twilio.Model.AccountMessageMedia.t()] | nil,
          :end => integer() | nil,
          :first_page_uri => String.t() | nil,
          :next_page_uri => String.t() | nil,
          :page => integer() | nil,
          :page_size => integer() | nil,
          :previous_page_uri => String.t() | nil,
          :start => integer() | nil,
          :uri => String.t() | nil
        }

  alias Heckler.Adapters.Twilio.Deserializer

  def decode(value) do
    value
    |> Deserializer.deserialize(
      :media_list,
      :list,
      Heckler.Adapters.Twilio.Model.AccountMessageMedia
    )
  end
end
