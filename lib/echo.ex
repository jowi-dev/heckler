defmodule Echo do
  @moduledoc """
  Echo is a notification library designed to minimize the pain of talking to your users.

  The goals of Echo are to provide a simple interface for scheduling, sending, and retrying notifications so that you can focus on the features that are unique to your application.
  To get started, review the tasks available via `mix help echo`, or generate a new push notification via `mix echo.gen.push $NAME`. Options for each command are explained in a familiar `mix help echo.gen.push`
  """

  @doc """
  Sends a push notification immediately
  """
  @spec send_push(map()) :: {:ok, map()}
  def send_push(payload) do
    schedule_push(payload, DateTime.utc_now())
  end

  @doc """
  Schedules a push notification for sending at a given time.
  """
  @spec schedule_push(map(), DateTime.t()) :: {:ok, map()}
  def schedule_push(_payload, _sent_at) do
    {:ok, %{}}
  end
end
