# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.AssignedAddOn do
  @moduledoc """
  API calls for all endpoints tagged `AssignedAddOn`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Assign an Add-on installation to the Number specified.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
  - `resource_sid` (String.t): The SID of the Phone Number to assign the Add-on.
  - `installed_add_on_sid` (String.t): The SID that identifies the Add-on installation.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_incoming_phone_number_assigned_add_on(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          String.t(),
          keyword()
        ) ::
          {:ok,
           Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn.t()}
          | {:error, Tesla.Env.t()}
  def create_incoming_phone_number_assigned_add_on(
        connection,
        account_sid,
        resource_sid,
        installed_add_on_sid,
        _opts \\ []
      ) do
    request =
      %{}
      |> method(:post)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/IncomingPhoneNumbers/#{resource_sid}/AssignedAddOns.json"
      )
      |> add_param(:form, :InstalledAddOnSid, installed_add_on_sid)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201,
       Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn}
    ])
  end

  @doc """
  Remove the assignment of an Add-on installation from the Number specified.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to delete.
  - `resource_sid` (String.t): The SID of the Phone Number to which the Add-on is assigned.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the resource to delete.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_incoming_phone_number_assigned_add_on(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          String.t(),
          keyword()
        ) :: {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_incoming_phone_number_assigned_add_on(
        connection,
        account_sid,
        resource_sid,
        sid,
        _opts \\ []
      ) do
    request =
      %{}
      |> method(:delete)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/IncomingPhoneNumbers/#{resource_sid}/AssignedAddOns/#{sid}.json"
      )
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  Fetch an instance of an Add-on installation currently assigned to this Number.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resource to fetch.
  - `resource_sid` (String.t): The SID of the Phone Number to which the Add-on is assigned.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_incoming_phone_number_assigned_add_on(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          String.t(),
          keyword()
        ) ::
          {:ok,
           Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn.t()}
          | {:error, Tesla.Env.t()}
  def fetch_incoming_phone_number_assigned_add_on(
        connection,
        account_sid,
        resource_sid,
        sid,
        _opts \\ []
      ) do
    request =
      %{}
      |> method(:get)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/IncomingPhoneNumbers/#{resource_sid}/AssignedAddOns/#{sid}.json"
      )
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200,
       Heckler.Adapters.Twilio.Model.AccountIncomingPhoneNumberIncomingPhoneNumberAssignedAddOn}
    ])
  end

  @doc """
  Retrieve a list of Add-on installations currently assigned to this Number.

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the resources to read.
  - `resource_sid` (String.t): The SID of the Phone Number to which the Add-on is assigned.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListIncomingPhoneNumberAssignedAddOnResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_incoming_phone_number_assigned_add_on(
          Tesla.Env.client(),
          String.t(),
          String.t(),
          keyword()
        ) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListIncomingPhoneNumberAssignedAddOnResponse.t()}
          | {:error, Tesla.Env.t()}
  def list_incoming_phone_number_assigned_add_on(
        connection,
        account_sid,
        resource_sid,
        opts \\ []
      ) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url(
        "/2010-04-01/Accounts/#{account_sid}/IncomingPhoneNumbers/#{resource_sid}/AssignedAddOns.json"
      )
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListIncomingPhoneNumberAssignedAddOnResponse}
    ])
  end
end
