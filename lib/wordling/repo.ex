defmodule Wordling.Repo do
  use Ecto.Repo,
    otp_app: :wordling,
    adapter: Ecto.Adapters.Postgres
end
