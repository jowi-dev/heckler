# NOTE: This file is auto generated by OpenAPI Generator 7.10.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule Heckler.Adapters.Twilio.Api.Yearly do
  @moduledoc """
  API calls for all endpoints tagged `Yearly`.
  """

  alias Heckler.Adapters.Twilio.Connection
  import Heckler.Adapters.Twilio.RequestBuilder

  @doc """
  

  ### Parameters

  - `connection` (Heckler.Adapters.Twilio.Connection): Connection to server
  - `account_sid` (String.t): The SID of the [Account](https://www.twilio.com/docs/iam/api/account) that created the UsageRecord resources to read.
  - `opts` (keyword): Optional parameters
    - `:Category` (UsageRecordYearlyEnumCategory): The [usage category](https://www.twilio.com/docs/usage/api/usage-record#usage-categories) of the UsageRecord resources to read. Only UsageRecord resources in the specified category are retrieved.
    - `:StartDate` (Date.t): Only include usage that has occurred on or after this date. Specify the date in GMT and format as `YYYY-MM-DD`. You can also specify offsets from the current date, such as: `-30days`, which will set the start date to be 30 days before the current date.
    - `:EndDate` (Date.t): Only include usage that occurred on or before this date. Specify the date in GMT and format as `YYYY-MM-DD`.  You can also specify offsets from the current date, such as: `+30days`, which will set the end date to 30 days from the current date.
    - `:IncludeSubaccounts` (boolean()): Whether to include usage from the master account and all its subaccounts. Can be: `true` (the default) to include usage from the master account and all subaccounts or `false` to retrieve usage from only the specified account.
    - `:PageSize` (integer()): How many resources to return in each list page. The default is 50, and the maximum is 1000.
    - `:Page` (integer()): The page index. This value is simply for client state.
    - `:PageToken` (String.t): The page token. This is provided by the API.

  ### Returns

  - `{:ok, Heckler.Adapters.Twilio.Model.ListUsageRecordYearlyResponse.t()}` on success
  - `{:error, Tesla.Env.t()}` on failure
  """
  @spec list_usage_record_yearly(Tesla.Env.client, String.t, keyword()) :: {:ok, Heckler.Adapters.Twilio.Model.ListUsageRecordYearlyResponse.t()} | {:error, Tesla.Env.t()}
  def list_usage_record_yearly(connection, account_sid, opts \\ []) do
    optional_params = %{
      :Category => :query,
      :StartDate => :query,
      :EndDate => :query,
      :IncludeSubaccounts => :query,
      :PageSize => :query,
      :Page => :query,
      :PageToken => :query
    }

    request =
      %{}
      |> method(:get)
      |> url("/2010-04-01/Accounts/#{account_sid}/Usage/Records/Yearly.json")
      |> add_optional_params(optional_params, opts)
      |> Enum.into([])

    connection
    |> Connection.request(request)
    |> evaluate_response([
      {200, Heckler.Adapters.Twilio.Model.ListUsageRecordYearlyResponse}
    ])
  end
end
