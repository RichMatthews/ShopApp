defmodule ShopApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ShopAppWeb.Telemetry,
      ShopApp.Repo,
      {DNSCluster, query: Application.get_env(:shop_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ShopApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ShopApp.Finch},
      # Start a worker by calling: ShopApp.Worker.start_link(arg)
      # {ShopApp.Worker, arg},
      # Start to serve requests, typically the last entry
      ShopAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShopApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ShopAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
