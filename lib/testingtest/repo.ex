defmodule Testingtest.Repo do
  use Ecto.Repo,
    otp_app: :testingtest,
    adapter: Ecto.Adapters.Postgres
end
