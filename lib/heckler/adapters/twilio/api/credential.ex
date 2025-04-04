# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Credential do
  @moduledoc """
  API calls for all endpoints tagged `Credential`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create a new credential resource.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique id of the Account that is responsible for this resource.
  - `credential_list_sid` (String.t): The unique id that identifies the credential list to include the created credential.
  - `username` (String.t): The username that will be passed when authenticating SIP requests. The username should be sent in response to Twilio's challenge of the initial INVITE. It can be up to 32 characters long.
  - `password` (String.t): The password that the username will use when authenticating SIP requests. The password must be a minimum of 12 characters, contain at least 1 digit, and have mixed case. (eg `IWasAtSignal2018`)
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_sip_credential(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          keyword()
        ) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}
          | {:error, Tesla.Env.t()}
  def create_sip_credential(
        connection,
        account_sid,
        credential_list_sid,
        username,
        password,
        _opts \\ []
      ) do
    request =
      %{}
      |> method(:post)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/SIP/CredentialLists/#{credential_list_sid}/Credentials.json"
      )
      |> add_param(:form, :Username, username)
      |> add_param(:form, :Password, password)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential}
    ])
  end

  @doc """
  Delete a credential resource.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique id of the Account that is responsible for this resource.
  - `credential_list_sid` (String.t): The unique id that identifies the credential list that contains the desired credentials.
  - `sid` (String.t): The unique id that identifies the resource to delete.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_sip_credential(Tesla.Env.client(), String.t(), String.t(), String.t(), keyword()) ::
          {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_sip_credential(connection, account_sid, credential_list_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/SIP/CredentialLists/#{credential_list_sid}/Credentials/#{sid}.json"
      )
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  Fetch a single credential.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique id of the Account that is responsible for this resource.
  - `credential_list_sid` (String.t): The unique id that identifies the credential list that contains the desired credential.
  - `sid` (String.t): The unique id that identifies the resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_sip_credential(Tesla.Env.client(), String.t(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}
          | {:error, Tesla.Env.t()}
  def fetch_sip_credential(connection, account_sid, credential_list_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/SIP/CredentialLists/#{credential_list_sid}/Credentials/#{sid}.json"
      )
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential}
    ])
  end

  @doc """
  Retrieve a list of credentials.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique id of the Account that is responsible for this resource.
  - `credential_list_sid` (String.t): The unique id that identifies the credential list that contains the desired credentials.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListSipCredentialResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_sip_credential(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListSipCredentialResponse.t()}
          | {:error, Tesla.Env.t()}
  def list_sip_credential(connection, account_sid, credential_list_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/SIP/CredentialLists/#{credential_list_sid}/Credentials.json"
      )
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListSipCredentialResponse}
    ])
  end

  @doc """
  Update a credential resource.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The unique id of the Account that is responsible for this resource.
  - `credential_list_sid` (String.t): The unique id that identifies the credential list that includes this credential.
  - `sid` (String.t): The unique id that identifies the resource to update.
  - `opts` (keyword): Optional parameters
    - `:Password` (String.t): The password that the username will use when authenticating SIP requests. The password must be a minimum of 12 characters, contain at least 1 digit, and have mixed case. (eg `IWasAtSignal2018`)

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_sip_credential(Tesla.Env.client(), String.t(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential.t()}
          | {:error, Tesla.Env.t()}
  def update_sip_credential(connection, account_sid, credential_list_sid, sid, opts \\ []) do
    optional_params = %{
      :Password => :form
    }

    request =
      %{}
      |> method(:post)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/SIP/CredentialLists/#{credential_list_sid}/Credentials/#{sid}.json"
      )
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountSipSipCredentialListSipCredential}
    ])
  end
end
