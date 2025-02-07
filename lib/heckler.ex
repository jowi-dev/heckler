defmodule Heckler do
  use Supervisor
  @moduledoc """
  Heckler is a notification library designed to minimize the pain of talking to your users.

  The goals of Heckler are to provide a simple interface for scheduling, sending, and retrying notifications so that you can focus on the features that are unique to your application.
  To get started, review the tasks available via `mix help heckler`, or generate a new push notification via `mix heckler.gen.push $NAME`. Options for each command are explained in a familiar `mix help heckler.gen.push`
  """

  def test_pn do
    notification = Pigeon.APNS.Notification.new("Hello world", "66da0125a857f32100a3cfb2ca9688252b8aa737469596a40a735c5c2c017df6", "family-recipe")
    Heckler.APNS.push(notification)
  end

  #@spec start_link([option()]) :: Supervisor.on_start()
  def start_link(opts) when is_list(opts) do
    #conf = Keyword.get(opts, :name, Heckler)
    #    children = [
    #      {Heckler.APNS, apns_opts()}
    #    ]
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
  #@spec child_spec([option]) :: Supervisor.child_spec()
  def child_spec(opts) do
    opts
    |> super()
    |> Supervisor.child_spec(id: Keyword.get(opts, :name, __MODULE__))
  end

  defp apns_opts do

    [
  adapter: Pigeon.APNS,
  key: File.read!("/Users/jowi/Projects/lib_heckler/AuthKey.p8"),
  key_identifier: "5XRLTUCS24",
  mode: :dev,
  team_id: "UPX69FSX5H"
    ]
  end

  defmacro __using__(_opts) do
    
    caller = List.first(__CALLER__.context_modules)
    quote do
      def hello() do
        app = Application.get_application(unquote(caller))
        Application.get_env(app, Heckler)
      end
    end
  end
end
