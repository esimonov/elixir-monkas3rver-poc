defmodule POCService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: Kaffe.Consumer,
        start: {Kaffe.Consumer, :start_link, []}
      },
      {
        Mongo,
        Application.get_env(:poc_service, :mongo)
      },
      {
        Plug.Cowboy,
        scheme: :http,
        plug: POCService.Router,
        options: [port: Application.get_env(:poc_service, :http_server_port)]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: POCService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
