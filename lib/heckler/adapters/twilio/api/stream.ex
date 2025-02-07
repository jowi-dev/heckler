# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Stream do
  @moduledoc """
  API calls for all endpoints tagged `Stream`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create a Stream

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource.
  - `call_sid` (String.t): The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with.
  - `url` (String.t): Relative or absolute URL where WebSocket connection will be established.
  - `opts` (keyword): Optional parameters
    - `:Name` (String.t): The user-specified name of this Stream, if one was given when the Stream was created. This can be used to stop the Stream.
    - `:Track` (Heckler.Adapters.Twilio.Model.StreamEnumTrack.t): 
    - `:StatusCallback` (String.t): Absolute URL to which Twilio sends status callback HTTP requests.
    - `:StatusCallbackMethod` (String.t): The HTTP method Twilio uses when sending `status_callback` requests. Possible values are `GET` and `POST`. Default is `POST`.
    - `:"Parameter1.Name"` (String.t): Parameter name
    - `:"Parameter1.Value"` (String.t): Parameter value
    - `:"Parameter2.Name"` (String.t): Parameter name
    - `:"Parameter2.Value"` (String.t): Parameter value
    - `:"Parameter3.Name"` (String.t): Parameter name
    - `:"Parameter3.Value"` (String.t): Parameter value
    - `:"Parameter4.Name"` (String.t): Parameter name
    - `:"Parameter4.Value"` (String.t): Parameter value
    - `:"Parameter5.Name"` (String.t): Parameter name
    - `:"Parameter5.Value"` (String.t): Parameter value
    - `:"Parameter6.Name"` (String.t): Parameter name
    - `:"Parameter6.Value"` (String.t): Parameter value
    - `:"Parameter7.Name"` (String.t): Parameter name
    - `:"Parameter7.Value"` (String.t): Parameter value
    - `:"Parameter8.Name"` (String.t): Parameter name
    - `:"Parameter8.Value"` (String.t): Parameter value
    - `:"Parameter9.Name"` (String.t): Parameter name
    - `:"Parameter9.Value"` (String.t): Parameter value
    - `:"Parameter10.Name"` (String.t): Parameter name
    - `:"Parameter10.Value"` (String.t): Parameter value
    - `:"Parameter11.Name"` (String.t): Parameter name
    - `:"Parameter11.Value"` (String.t): Parameter value
    - `:"Parameter12.Name"` (String.t): Parameter name
    - `:"Parameter12.Value"` (String.t): Parameter value
    - `:"Parameter13.Name"` (String.t): Parameter name
    - `:"Parameter13.Value"` (String.t): Parameter value
    - `:"Parameter14.Name"` (String.t): Parameter name
    - `:"Parameter14.Value"` (String.t): Parameter value
    - `:"Parameter15.Name"` (String.t): Parameter name
    - `:"Parameter15.Value"` (String.t): Parameter value
    - `:"Parameter16.Name"` (String.t): Parameter name
    - `:"Parameter16.Value"` (String.t): Parameter value
    - `:"Parameter17.Name"` (String.t): Parameter name
    - `:"Parameter17.Value"` (String.t): Parameter value
    - `:"Parameter18.Name"` (String.t): Parameter name
    - `:"Parameter18.Value"` (String.t): Parameter value
    - `:"Parameter19.Name"` (String.t): Parameter name
    - `:"Parameter19.Value"` (String.t): Parameter value
    - `:"Parameter20.Name"` (String.t): Parameter name
    - `:"Parameter20.Value"` (String.t): Parameter value
    - `:"Parameter21.Name"` (String.t): Parameter name
    - `:"Parameter21.Value"` (String.t): Parameter value
    - `:"Parameter22.Name"` (String.t): Parameter name
    - `:"Parameter22.Value"` (String.t): Parameter value
    - `:"Parameter23.Name"` (String.t): Parameter name
    - `:"Parameter23.Value"` (String.t): Parameter value
    - `:"Parameter24.Name"` (String.t): Parameter name
    - `:"Parameter24.Value"` (String.t): Parameter value
    - `:"Parameter25.Name"` (String.t): Parameter name
    - `:"Parameter25.Value"` (String.t): Parameter value
    - `:"Parameter26.Name"` (String.t): Parameter name
    - `:"Parameter26.Value"` (String.t): Parameter value
    - `:"Parameter27.Name"` (String.t): Parameter name
    - `:"Parameter27.Value"` (String.t): Parameter value
    - `:"Parameter28.Name"` (String.t): Parameter name
    - `:"Parameter28.Value"` (String.t): Parameter value
    - `:"Parameter29.Name"` (String.t): Parameter name
    - `:"Parameter29.Value"` (String.t): Parameter value
    - `:"Parameter30.Name"` (String.t): Parameter name
    - `:"Parameter30.Value"` (String.t): Parameter value
    - `:"Parameter31.Name"` (String.t): Parameter name
    - `:"Parameter31.Value"` (String.t): Parameter value
    - `:"Parameter32.Name"` (String.t): Parameter name
    - `:"Parameter32.Value"` (String.t): Parameter value
    - `:"Parameter33.Name"` (String.t): Parameter name
    - `:"Parameter33.Value"` (String.t): Parameter value
    - `:"Parameter34.Name"` (String.t): Parameter name
    - `:"Parameter34.Value"` (String.t): Parameter value
    - `:"Parameter35.Name"` (String.t): Parameter name
    - `:"Parameter35.Value"` (String.t): Parameter value
    - `:"Parameter36.Name"` (String.t): Parameter name
    - `:"Parameter36.Value"` (String.t): Parameter value
    - `:"Parameter37.Name"` (String.t): Parameter name
    - `:"Parameter37.Value"` (String.t): Parameter value
    - `:"Parameter38.Name"` (String.t): Parameter name
    - `:"Parameter38.Value"` (String.t): Parameter value
    - `:"Parameter39.Name"` (String.t): Parameter name
    - `:"Parameter39.Value"` (String.t): Parameter value
    - `:"Parameter40.Name"` (String.t): Parameter name
    - `:"Parameter40.Value"` (String.t): Parameter value
    - `:"Parameter41.Name"` (String.t): Parameter name
    - `:"Parameter41.Value"` (String.t): Parameter value
    - `:"Parameter42.Name"` (String.t): Parameter name
    - `:"Parameter42.Value"` (String.t): Parameter value
    - `:"Parameter43.Name"` (String.t): Parameter name
    - `:"Parameter43.Value"` (String.t): Parameter value
    - `:"Parameter44.Name"` (String.t): Parameter name
    - `:"Parameter44.Value"` (String.t): Parameter value
    - `:"Parameter45.Name"` (String.t): Parameter name
    - `:"Parameter45.Value"` (String.t): Parameter value
    - `:"Parameter46.Name"` (String.t): Parameter name
    - `:"Parameter46.Value"` (String.t): Parameter value
    - `:"Parameter47.Name"` (String.t): Parameter name
    - `:"Parameter47.Value"` (String.t): Parameter value
    - `:"Parameter48.Name"` (String.t): Parameter name
    - `:"Parameter48.Value"` (String.t): Parameter value
    - `:"Parameter49.Name"` (String.t): Parameter name
    - `:"Parameter49.Value"` (String.t): Parameter value
    - `:"Parameter50.Name"` (String.t): Parameter name
    - `:"Parameter50.Value"` (String.t): Parameter value
    - `:"Parameter51.Name"` (String.t): Parameter name
    - `:"Parameter51.Value"` (String.t): Parameter value
    - `:"Parameter52.Name"` (String.t): Parameter name
    - `:"Parameter52.Value"` (String.t): Parameter value
    - `:"Parameter53.Name"` (String.t): Parameter name
    - `:"Parameter53.Value"` (String.t): Parameter value
    - `:"Parameter54.Name"` (String.t): Parameter name
    - `:"Parameter54.Value"` (String.t): Parameter value
    - `:"Parameter55.Name"` (String.t): Parameter name
    - `:"Parameter55.Value"` (String.t): Parameter value
    - `:"Parameter56.Name"` (String.t): Parameter name
    - `:"Parameter56.Value"` (String.t): Parameter value
    - `:"Parameter57.Name"` (String.t): Parameter name
    - `:"Parameter57.Value"` (String.t): Parameter value
    - `:"Parameter58.Name"` (String.t): Parameter name
    - `:"Parameter58.Value"` (String.t): Parameter value
    - `:"Parameter59.Name"` (String.t): Parameter name
    - `:"Parameter59.Value"` (String.t): Parameter value
    - `:"Parameter60.Name"` (String.t): Parameter name
    - `:"Parameter60.Value"` (String.t): Parameter value
    - `:"Parameter61.Name"` (String.t): Parameter name
    - `:"Parameter61.Value"` (String.t): Parameter value
    - `:"Parameter62.Name"` (String.t): Parameter name
    - `:"Parameter62.Value"` (String.t): Parameter value
    - `:"Parameter63.Name"` (String.t): Parameter name
    - `:"Parameter63.Value"` (String.t): Parameter value
    - `:"Parameter64.Name"` (String.t): Parameter name
    - `:"Parameter64.Value"` (String.t): Parameter value
    - `:"Parameter65.Name"` (String.t): Parameter name
    - `:"Parameter65.Value"` (String.t): Parameter value
    - `:"Parameter66.Name"` (String.t): Parameter name
    - `:"Parameter66.Value"` (String.t): Parameter value
    - `:"Parameter67.Name"` (String.t): Parameter name
    - `:"Parameter67.Value"` (String.t): Parameter value
    - `:"Parameter68.Name"` (String.t): Parameter name
    - `:"Parameter68.Value"` (String.t): Parameter value
    - `:"Parameter69.Name"` (String.t): Parameter name
    - `:"Parameter69.Value"` (String.t): Parameter value
    - `:"Parameter70.Name"` (String.t): Parameter name
    - `:"Parameter70.Value"` (String.t): Parameter value
    - `:"Parameter71.Name"` (String.t): Parameter name
    - `:"Parameter71.Value"` (String.t): Parameter value
    - `:"Parameter72.Name"` (String.t): Parameter name
    - `:"Parameter72.Value"` (String.t): Parameter value
    - `:"Parameter73.Name"` (String.t): Parameter name
    - `:"Parameter73.Value"` (String.t): Parameter value
    - `:"Parameter74.Name"` (String.t): Parameter name
    - `:"Parameter74.Value"` (String.t): Parameter value
    - `:"Parameter75.Name"` (String.t): Parameter name
    - `:"Parameter75.Value"` (String.t): Parameter value
    - `:"Parameter76.Name"` (String.t): Parameter name
    - `:"Parameter76.Value"` (String.t): Parameter value
    - `:"Parameter77.Name"` (String.t): Parameter name
    - `:"Parameter77.Value"` (String.t): Parameter value
    - `:"Parameter78.Name"` (String.t): Parameter name
    - `:"Parameter78.Value"` (String.t): Parameter value
    - `:"Parameter79.Name"` (String.t): Parameter name
    - `:"Parameter79.Value"` (String.t): Parameter value
    - `:"Parameter80.Name"` (String.t): Parameter name
    - `:"Parameter80.Value"` (String.t): Parameter value
    - `:"Parameter81.Name"` (String.t): Parameter name
    - `:"Parameter81.Value"` (String.t): Parameter value
    - `:"Parameter82.Name"` (String.t): Parameter name
    - `:"Parameter82.Value"` (String.t): Parameter value
    - `:"Parameter83.Name"` (String.t): Parameter name
    - `:"Parameter83.Value"` (String.t): Parameter value
    - `:"Parameter84.Name"` (String.t): Parameter name
    - `:"Parameter84.Value"` (String.t): Parameter value
    - `:"Parameter85.Name"` (String.t): Parameter name
    - `:"Parameter85.Value"` (String.t): Parameter value
    - `:"Parameter86.Name"` (String.t): Parameter name
    - `:"Parameter86.Value"` (String.t): Parameter value
    - `:"Parameter87.Name"` (String.t): Parameter name
    - `:"Parameter87.Value"` (String.t): Parameter value
    - `:"Parameter88.Name"` (String.t): Parameter name
    - `:"Parameter88.Value"` (String.t): Parameter value
    - `:"Parameter89.Name"` (String.t): Parameter name
    - `:"Parameter89.Value"` (String.t): Parameter value
    - `:"Parameter90.Name"` (String.t): Parameter name
    - `:"Parameter90.Value"` (String.t): Parameter value
    - `:"Parameter91.Name"` (String.t): Parameter name
    - `:"Parameter91.Value"` (String.t): Parameter value
    - `:"Parameter92.Name"` (String.t): Parameter name
    - `:"Parameter92.Value"` (String.t): Parameter value
    - `:"Parameter93.Name"` (String.t): Parameter name
    - `:"Parameter93.Value"` (String.t): Parameter value
    - `:"Parameter94.Name"` (String.t): Parameter name
    - `:"Parameter94.Value"` (String.t): Parameter value
    - `:"Parameter95.Name"` (String.t): Parameter name
    - `:"Parameter95.Value"` (String.t): Parameter value
    - `:"Parameter96.Name"` (String.t): Parameter name
    - `:"Parameter96.Value"` (String.t): Parameter value
    - `:"Parameter97.Name"` (String.t): Parameter name
    - `:"Parameter97.Value"` (String.t): Parameter value
    - `:"Parameter98.Name"` (String.t): Parameter name
    - `:"Parameter98.Value"` (String.t): Parameter value
    - `:"Parameter99.Name"` (String.t): Parameter name
    - `:"Parameter99.Value"` (String.t): Parameter value

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountCallStream.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_stream(Tesla.Env.client, String.t, String.t, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.AccountCallStream.t()} | {:error, Tesla.Env.t()}
  def create_stream(connection, account_sid, call_sid, url, opts \\ []) do
    optional_params = %{
      :Name => :form,
      :Track => :form,
      :StatusCallback => :form,
      :StatusCallbackMethod => :form,
      :"Parameter1.Name" => :form,
      :"Parameter1.Value" => :form,
      :"Parameter2.Name" => :form,
      :"Parameter2.Value" => :form,
      :"Parameter3.Name" => :form,
      :"Parameter3.Value" => :form,
      :"Parameter4.Name" => :form,
      :"Parameter4.Value" => :form,
      :"Parameter5.Name" => :form,
      :"Parameter5.Value" => :form,
      :"Parameter6.Name" => :form,
      :"Parameter6.Value" => :form,
      :"Parameter7.Name" => :form,
      :"Parameter7.Value" => :form,
      :"Parameter8.Name" => :form,
      :"Parameter8.Value" => :form,
      :"Parameter9.Name" => :form,
      :"Parameter9.Value" => :form,
      :"Parameter10.Name" => :form,
      :"Parameter10.Value" => :form,
      :"Parameter11.Name" => :form,
      :"Parameter11.Value" => :form,
      :"Parameter12.Name" => :form,
      :"Parameter12.Value" => :form,
      :"Parameter13.Name" => :form,
      :"Parameter13.Value" => :form,
      :"Parameter14.Name" => :form,
      :"Parameter14.Value" => :form,
      :"Parameter15.Name" => :form,
      :"Parameter15.Value" => :form,
      :"Parameter16.Name" => :form,
      :"Parameter16.Value" => :form,
      :"Parameter17.Name" => :form,
      :"Parameter17.Value" => :form,
      :"Parameter18.Name" => :form,
      :"Parameter18.Value" => :form,
      :"Parameter19.Name" => :form,
      :"Parameter19.Value" => :form,
      :"Parameter20.Name" => :form,
      :"Parameter20.Value" => :form,
      :"Parameter21.Name" => :form,
      :"Parameter21.Value" => :form,
      :"Parameter22.Name" => :form,
      :"Parameter22.Value" => :form,
      :"Parameter23.Name" => :form,
      :"Parameter23.Value" => :form,
      :"Parameter24.Name" => :form,
      :"Parameter24.Value" => :form,
      :"Parameter25.Name" => :form,
      :"Parameter25.Value" => :form,
      :"Parameter26.Name" => :form,
      :"Parameter26.Value" => :form,
      :"Parameter27.Name" => :form,
      :"Parameter27.Value" => :form,
      :"Parameter28.Name" => :form,
      :"Parameter28.Value" => :form,
      :"Parameter29.Name" => :form,
      :"Parameter29.Value" => :form,
      :"Parameter30.Name" => :form,
      :"Parameter30.Value" => :form,
      :"Parameter31.Name" => :form,
      :"Parameter31.Value" => :form,
      :"Parameter32.Name" => :form,
      :"Parameter32.Value" => :form,
      :"Parameter33.Name" => :form,
      :"Parameter33.Value" => :form,
      :"Parameter34.Name" => :form,
      :"Parameter34.Value" => :form,
      :"Parameter35.Name" => :form,
      :"Parameter35.Value" => :form,
      :"Parameter36.Name" => :form,
      :"Parameter36.Value" => :form,
      :"Parameter37.Name" => :form,
      :"Parameter37.Value" => :form,
      :"Parameter38.Name" => :form,
      :"Parameter38.Value" => :form,
      :"Parameter39.Name" => :form,
      :"Parameter39.Value" => :form,
      :"Parameter40.Name" => :form,
      :"Parameter40.Value" => :form,
      :"Parameter41.Name" => :form,
      :"Parameter41.Value" => :form,
      :"Parameter42.Name" => :form,
      :"Parameter42.Value" => :form,
      :"Parameter43.Name" => :form,
      :"Parameter43.Value" => :form,
      :"Parameter44.Name" => :form,
      :"Parameter44.Value" => :form,
      :"Parameter45.Name" => :form,
      :"Parameter45.Value" => :form,
      :"Parameter46.Name" => :form,
      :"Parameter46.Value" => :form,
      :"Parameter47.Name" => :form,
      :"Parameter47.Value" => :form,
      :"Parameter48.Name" => :form,
      :"Parameter48.Value" => :form,
      :"Parameter49.Name" => :form,
      :"Parameter49.Value" => :form,
      :"Parameter50.Name" => :form,
      :"Parameter50.Value" => :form,
      :"Parameter51.Name" => :form,
      :"Parameter51.Value" => :form,
      :"Parameter52.Name" => :form,
      :"Parameter52.Value" => :form,
      :"Parameter53.Name" => :form,
      :"Parameter53.Value" => :form,
      :"Parameter54.Name" => :form,
      :"Parameter54.Value" => :form,
      :"Parameter55.Name" => :form,
      :"Parameter55.Value" => :form,
      :"Parameter56.Name" => :form,
      :"Parameter56.Value" => :form,
      :"Parameter57.Name" => :form,
      :"Parameter57.Value" => :form,
      :"Parameter58.Name" => :form,
      :"Parameter58.Value" => :form,
      :"Parameter59.Name" => :form,
      :"Parameter59.Value" => :form,
      :"Parameter60.Name" => :form,
      :"Parameter60.Value" => :form,
      :"Parameter61.Name" => :form,
      :"Parameter61.Value" => :form,
      :"Parameter62.Name" => :form,
      :"Parameter62.Value" => :form,
      :"Parameter63.Name" => :form,
      :"Parameter63.Value" => :form,
      :"Parameter64.Name" => :form,
      :"Parameter64.Value" => :form,
      :"Parameter65.Name" => :form,
      :"Parameter65.Value" => :form,
      :"Parameter66.Name" => :form,
      :"Parameter66.Value" => :form,
      :"Parameter67.Name" => :form,
      :"Parameter67.Value" => :form,
      :"Parameter68.Name" => :form,
      :"Parameter68.Value" => :form,
      :"Parameter69.Name" => :form,
      :"Parameter69.Value" => :form,
      :"Parameter70.Name" => :form,
      :"Parameter70.Value" => :form,
      :"Parameter71.Name" => :form,
      :"Parameter71.Value" => :form,
      :"Parameter72.Name" => :form,
      :"Parameter72.Value" => :form,
      :"Parameter73.Name" => :form,
      :"Parameter73.Value" => :form,
      :"Parameter74.Name" => :form,
      :"Parameter74.Value" => :form,
      :"Parameter75.Name" => :form,
      :"Parameter75.Value" => :form,
      :"Parameter76.Name" => :form,
      :"Parameter76.Value" => :form,
      :"Parameter77.Name" => :form,
      :"Parameter77.Value" => :form,
      :"Parameter78.Name" => :form,
      :"Parameter78.Value" => :form,
      :"Parameter79.Name" => :form,
      :"Parameter79.Value" => :form,
      :"Parameter80.Name" => :form,
      :"Parameter80.Value" => :form,
      :"Parameter81.Name" => :form,
      :"Parameter81.Value" => :form,
      :"Parameter82.Name" => :form,
      :"Parameter82.Value" => :form,
      :"Parameter83.Name" => :form,
      :"Parameter83.Value" => :form,
      :"Parameter84.Name" => :form,
      :"Parameter84.Value" => :form,
      :"Parameter85.Name" => :form,
      :"Parameter85.Value" => :form,
      :"Parameter86.Name" => :form,
      :"Parameter86.Value" => :form,
      :"Parameter87.Name" => :form,
      :"Parameter87.Value" => :form,
      :"Parameter88.Name" => :form,
      :"Parameter88.Value" => :form,
      :"Parameter89.Name" => :form,
      :"Parameter89.Value" => :form,
      :"Parameter90.Name" => :form,
      :"Parameter90.Value" => :form,
      :"Parameter91.Name" => :form,
      :"Parameter91.Value" => :form,
      :"Parameter92.Name" => :form,
      :"Parameter92.Value" => :form,
      :"Parameter93.Name" => :form,
      :"Parameter93.Value" => :form,
      :"Parameter94.Name" => :form,
      :"Parameter94.Value" => :form,
      :"Parameter95.Name" => :form,
      :"Parameter95.Value" => :form,
      :"Parameter96.Name" => :form,
      :"Parameter96.Value" => :form,
      :"Parameter97.Name" => :form,
      :"Parameter97.Value" => :form,
      :"Parameter98.Name" => :form,
      :"Parameter98.Value" => :form,
      :"Parameter99.Name" => :form,
      :"Parameter99.Value" => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/Calls/#{call_sid}/Streams.json")
      |> add_param(:form, :Url, url)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountCallStream}
    ])
  end

  @doc """
  Stop a Stream using either the SID of the Stream resource or the `name` used when creating the resource

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created this Stream resource.
  - `call_sid` (String.t): The SID of the [Call](https://www.twilio.com/docs/voice/api/call-resource) the Stream resource is associated with.
  - `sid` (String.t): The SID or the `name` of the Stream resource to be stopped
  - `status` (Heckler.Adapters.Twilio.Model.StreamEnumUpdateStatus.t): 
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountCallStream.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_stream(Tesla.Env.client, String.t, String.t, String.t, Heckler.Adapters.Twilio.Model.StreamEnumUpdateStatus.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.AccountCallStream.t()} | {:error, Tesla.Env.t()}
  def update_stream(connection, account_sid, call_sid, sid, status, _opts \\ []) do
    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/Calls/#{call_sid}/Streams/#{sid}.json")
      |> add_param(:form, :Status, status)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountCallStream}
    ])
  end
end
