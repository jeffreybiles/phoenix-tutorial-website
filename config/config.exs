# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tutorial_site,
  ecto_repos: [TutorialSite.Repo]

# Configures the endpoint
config :tutorial_site, TutorialSiteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "m90lOmRhiFElbuld46HfOGzoGJ/9Hqp8+acEq/+ZQsyELGy+15Rweim+VO9hXsPe",
  render_errors: [view: TutorialSiteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TutorialSite.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
