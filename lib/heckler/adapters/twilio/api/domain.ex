# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Domain do
  @moduledoc """
  API calls for all endpoints tagged `Domain`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  Create a new Domain

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that will create the resource.
  - `domain_name` (String.t): The unique address you reserve on Twilio to which you route your SIP traffic. Domain names can contain letters, digits, and \\\"-\\\" and must end with `sip.twilio.com`.
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A descriptive string that you created to describe the resource. It can be up to 64 characters long.
    - `:VoiceUrl` (String.t): The URL we should when the domain receives a call.
    - `:VoiceMethod` (String.t): The HTTP method we should use to call `voice_url`. Can be: `GET` or `POST`.
    - `:VoiceFallbackUrl` (String.t): The URL that we should call when an error occurs while retrieving or executing the TwiML from `voice_url`.
    - `:VoiceFallbackMethod` (String.t): The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`.
    - `:VoiceStatusCallbackUrl` (String.t): The URL that we should call to pass status parameters (such as call ended) to your application.
    - `:VoiceStatusCallbackMethod` (String.t): The HTTP method we should use to call `voice_status_callback_url`. Can be: `GET` or `POST`.
    - `:SipRegistration` (boolean()): Whether to allow SIP Endpoints to register with the domain to receive calls. Can be `true` or `false`. `true` allows SIP Endpoints to register with the domain to receive calls, `false` does not.
    - `:EmergencyCallingEnabled` (boolean()): Whether emergency calling is enabled for the domain. If enabled, allows emergency calls on the domain from phone numbers with validated addresses.
    - `:Secure` (boolean()): Whether secure SIP is enabled for the domain. If enabled, TLS will be enforced and SRTP will be negotiated on all incoming calls to this sip domain.
    - `:ByocTrunkSid` (String.t): The SID of the BYOC Trunk(Bring Your Own Carrier) resource that the Sip Domain will be associated with.
    - `:EmergencyCallerSid` (String.t): Whether an emergency caller sid is configured for the domain. If present, this phone number will be used as the callback for the emergency call.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec create_sip_domain(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()} | {:error, Tesla.Env.t()}
  def create_sip_domain(connection, account_sid, domain_name, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :VoiceUrl => :form,
      :VoiceMethod => :form,
      :VoiceFallbackUrl => :form,
      :VoiceFallbackMethod => :form,
      :VoiceStatusCallbackUrl => :form,
      :VoiceStatusCallbackMethod => :form,
      :SipRegistration => :form,
      :EmergencyCallingEnabled => :form,
      :Secure => :form,
      :ByocTrunkSid => :form,
      :EmergencyCallerSid => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/SIP/Domains.json")
      |> add_param(:form, :DomainName, domain_name)
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {201, Heckler.Adapters.Twilio.Model.AccountSipSipDomain}
    ])
  end

  @doc """
  Delete an instance of a Domain

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to delete.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the SipDomain resource to delete.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, nil}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec delete_sip_domain(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, nil} | {:error, Tesla.Env.t()}
  def delete_sip_domain(connection, account_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:delete)
      |> url("/2010-04-01/Accounts/#{account_sid}/SIP/Domains/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {204, false}
    ])
  end

  @doc """
  Fetch an instance of a Domain

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to fetch.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the SipDomain resource to fetch.
  - `opts` (keyword): Optional parameters

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec fetch_sip_domain(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()} | {:error, Tesla.Env.t()}
  def fetch_sip_domain(connection, account_sid, sid, _opts \\ []) do
    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/SIP/Domains/#{sid}.json")
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountSipSipDomain}
    ])
  end

  @doc """
  Retrieve a list of domains belonging to the account used to make the request

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resources to read.
  - `opts` (keyword): Optional parameters
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListSipDomainResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_sip_domain(Tesla.Env.client(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.ListSipDomainResponse.t()} | {:error, Tesla.Env.t()}
  def list_sip_domain(connection, account_sid, opts \\ []) do
    optional_params = %{
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/SIP/Domains.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListSipDomainResponse}
    ])
  end

  @doc """
  Update the attributes of a domain

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the SipDomain resource to update.
  - `sid` (String.t): The Twilio-provided string that uniquely identifies the SipDomain resource to update.
  - `opts` (keyword): Optional parameters
    - `:FriendlyName` (String.t): A descriptive string that you created to describe the resource. It can be up to 64 characters long.
    - `:VoiceFallbackMethod` (String.t): The HTTP method we should use to call `voice_fallback_url`. Can be: `GET` or `POST`.
    - `:VoiceFallbackUrl` (String.t): The URL that we should call when an error occurs while retrieving or executing the TwiML requested by `voice_url`.
    - `:VoiceMethod` (String.t): The HTTP method we should use to call `voice_url`
    - `:VoiceStatusCallbackMethod` (String.t): The HTTP method we should use to call `voice_status_callback_url`. Can be: `GET` or `POST`.
    - `:VoiceStatusCallbackUrl` (String.t): The URL that we should call to pass status parameters (such as call ended) to your application.
    - `:VoiceUrl` (String.t): The URL we should call when the domain receives a call.
    - `:SipRegistration` (boolean()): Whether to allow SIP Endpoints to register with the domain to receive calls. Can be `true` or `false`. `true` allows SIP Endpoints to register with the domain to receive calls, `false` does not.
    - `:DomainName` (String.t): The unique address you reserve on Twilio to which you route your SIP traffic. Domain names can contain letters, digits, and \\\"-\\\" and must end with `sip.twilio.com`.
    - `:EmergencyCallingEnabled` (boolean()): Whether emergency calling is enabled for the domain. If enabled, allows emergency calls on the domain from phone numbers with validated addresses.
    - `:Secure` (boolean()): Whether secure SIP is enabled for the domain. If enabled, TLS will be enforced and SRTP will be negotiated on all incoming calls to this sip domain.
    - `:ByocTrunkSid` (String.t): The SID of the BYOC Trunk(Bring Your Own Carrier) resource that the Sip Domain will be associated with.
    - `:EmergencyCallerSid` (String.t): Whether an emergency caller sid is configured for the domain. If present, this phone number will be used as the callback for the emergency call.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec update_sip_domain(Tesla.Env.client(), String.t(), String.t(), keyword()) ::
          {:ok, Heckler.Adapters.Twilio.Model.AccountSipSipDomain.t()} | {:error, Tesla.Env.t()}
  def update_sip_domain(connection, account_sid, sid, opts \\ []) do
    optional_params = %{
      :FriendlyName => :form,
      :VoiceFallbackMethod => :form,
      :VoiceFallbackUrl => :form,
      :VoiceMethod => :form,
      :VoiceStatusCallbackMethod => :form,
      :VoiceStatusCallbackUrl => :form,
      :VoiceUrl => :form,
      :SipRegistration => :form,
      :DomainName => :form,
      :EmergencyCallingEnabled => :form,
      :Secure => :form,
      :ByocTrunkSid => :form,
      :EmergencyCallerSid => :form
    }

    request =
      %{}
      |> method(:post)
      |> url("/2010-04-01/Accounts/#{account_sid}/SIP/Domains/#{sid}.json")
      |> add_optional_params(optional_params, opts)
      |> ensure_body()
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.AccountSipSipDomain}
    ])
  end
end
