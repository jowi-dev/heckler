# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Account do
  @moduledoc """
  API calls for all endpoints tagged `Account`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create a new Twilio Subaccount from the account making the request

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A human readable description of the account to create, defaults to `SubAccount Created at {YYYY-MM-DD HH:MM meridian}`

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.Account.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_account(Tesla.Env.client, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.Account.t()} | {:error, Tesla.Env.t()}
  def create_account(connection, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, Heckler.Adapters.Twilio.Model.Account}
    ])
  end

  @doc """
  Fetch the account specified by the provided Account Sid

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `sid` (String.t): The Account Sid that uniquely identifies the account to fetch
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.Account.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_account(Tesla.Env.client, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.Account.t()} | {:error, Tesla.Env.t()}
  def fetch_account(connection, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.Account}
    ])
  end

  @doc """
  Retrieves a collection of Accounts belonging to the account used to make the request

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): Only return the Account resources with friendly names that exactly match this name.
    - `:Status` (AccountEnumStatus): Only return Account resources with the given status. Can be `closed`, `suspended` or `active`.
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListAccountResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_account(Tesla.Env.client, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.ListAccountResponse.t()} | {:error, Tesla.Env.t()}
  def list_account(connection, opts \\ []) do
    optional_params = %{
      :FriendlyName => :query,
      :Status => :query,
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListAccountResponse}
    ])
  end

  @doc """
  Modify the properties of a given Account

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `sid` (String.t): The Account Sid that uniquely identifies the account to update
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): Update the human-readable description of this Account
    - `:Status` (Heckler.Adapters.Twilio.Model.AccountEnumStatus.t): 

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.Account.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_account(Tesla.Env.client, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.Account.t()} | {:error, Tesla.Env.t()}
  def update_account(connection, sid, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :Status => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{sid}.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.Account}
    ])
  end
end
