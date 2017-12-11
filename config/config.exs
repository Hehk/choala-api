# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :choala_api,
  ecto_repos: [ChoalaApi.Repo]

# Configures the endpoint
config :choala_api, ChoalaApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YyD5g5NgA7t8rFrBduoBERS3axQp2tyV7PXvpC/wujqYoM7c8fDN/Jd9NE/iOFYQ",
  render_errors: [view: ChoalaApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ChoalaApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
