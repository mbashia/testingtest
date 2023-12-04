defmodule Testingtest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TestingtestWeb.Telemetry,
      Testingtest.Repo,
      {DNSCluster, query: Application.get_env(:testingtest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Testingtest.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Testingtest.Finch},
      # Start a worker by calling: Testingtest.Worker.start_link(arg)
      # {Testingtest.Worker, arg},
      # Start to serve requests, typically the last entry
      TestingtestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Testingtest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestingtestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
