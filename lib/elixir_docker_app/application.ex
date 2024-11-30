defmodule ElixirDockerApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirDockerAppWeb.Telemetry,
      ElixirDockerApp.Repo,
      {DNSCluster, query: Application.get_env(:elixir_docker_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirDockerApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirDockerApp.Finch},
      # Start a worker by calling: ElixirDockerApp.Worker.start_link(arg)
      # {ElixirDockerApp.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirDockerAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirDockerApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirDockerAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
