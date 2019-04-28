defmodule TutorialSite.Repo do
  use Ecto.Repo,
    otp_app: :tutorial_site,
    adapter: Ecto.Adapters.Postgres
end
