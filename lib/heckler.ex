defmodule Heckler do
  use Supervisor
  @moduledoc """
  Heckler is a notification library designed to minimize the pain of talking to your users.

  The goals of Heckler are to provide a simple interface for scheduling, sending, and retrying notifications so that you can focus on the features that are unique to your application.
  To get started, review the tasks available via `mix help heckler`, or generate a new push notification via `mix heckler.gen.push $NAME`. Options for each command are explained in a familiar `mix help heckler.gen.push`
  """


  @spec start_link([Supervisor.option()]) :: Supervisor.on_start()
  def start_link(opts) when is_list(opts) do
    sup_opts = [strategy: :one_for_one, name: Heckler]
    Supervisor.start_link(__MODULE__, opts, sup_opts)
  end

  def init(_opts) do
    children = [
      {Heckler.APNS, apns_opts()}
    ]
    Supervisor.init(children, [strategy: :one_for_one, name: Heckler.Supervisor])
  end

  @doc false
  @spec child_spec([Supervisor.option()]) :: Supervisor.child_spec()
  def child_spec(opts) do
    opts
    |> super()
    |> Supervisor.child_spec(id: Keyword.get(opts, :name, __MODULE__))
  end

  defp apns_opts do
    [
      adapter: Pigeon.APNS,
      key: File.read!(System.get_env("APNS_AUTH_KEY_PATH")),
      key_identifier: System.get_env("APNS_KEY_IDENTIFIER"),
      mode: :dev,
      team_id: System.get_env("APNS_TEAM_ID")
    ]
  end

  # -----------------------------------------------------------------------------
  #  if we decide to go back to using a macro style library I'll uncomment
  # and pull this back into usage. For now function calls make way more sense
  # -----------------------------------------------------------------------------
  #  defmacro __using__(_opts) do
  #    caller = List.first(__CALLER__.context_modules)
  #    quote do
  #      def hello() do
  #        app = Application.get_application(unquote(caller))
  #        Application.get_env(app, Heckler)
  #      end
  #    end
  #  end
end
