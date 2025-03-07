# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Queue do
  @moduledoc """
  API calls for all endpoints tagged `Queue`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create a queue

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
  - `friendly_name` (String.t): A descriptive string that you created to describe this resource. It can be up to 64 characters long.
  - `opts` (keyword): Optional parameters
    - `:MaxSize` (integer()): The maximum number of calls allowed to be in the queue. The default is 1000. The maximum is 5000.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_queue(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()} | {:error, Tesla.Env.t()}
  def create_queue(connection, account_sid, friendly_name, opts \\ []) do
    optional_params = %{
      :MaxSize => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/Queues.json")
      |> add_param(:form, :FriendlyName, friendly_name)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, Heckler.Adapters.Twilio.Model.AccountQueue}
    ])
  end

  @doc """
  Remove an empty queue

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to delete.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Queue resource to delete
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_queue(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_queue(connection, account_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/2010-04-01/Accounts/#{account_sid}/Queues/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  Fetch an instance of a queue identified by the QueueSid

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to fetch.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Queue resource to fetch
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_queue(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()} | {:error, Tesla.Env.t()}
  def fetch_queue(connection, account_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Queues/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountQueue}
    ])
  end

  @doc """
  Retrieve a list of queues belonging to the account used to make the request

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resources to read.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListQueueResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_queue(Tesla.Env.client(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListQueueResponse.t()} | {:error, Tesla.Env.t()}
  def list_queue(connection, account_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Queues.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListQueueResponse}
    ])
  end

  @doc """
  Update the queue with the new parameters

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the Queue resource to update.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the Queue resource to update
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A descriptive string that you created to describe this resource. It can be up to 64 characters long.
    - `:MaxSize` (integer()): The maximum number of calls allowed to be in the queue. The default is 1000. The maximum is 5000.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_queue(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountQueue.t()} | {:error, Tesla.Env.t()}
  def update_queue(connection, account_sid, sid, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :MaxSize => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/Queues/#{sid}.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountQueue}
    ])
  end
end
