defmodule ElixirDockerApp.Repo do
  use Ecto.Repo,
    otp_app: :elixir_docker_app,
    adapter: Ecto.Adapters.Postgres
end
