# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scanner,
  ecto_repos: [Scanner.Repo]

# Configures the endpoint
config :scanner, Scanner.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xWRwAleQ4LqnxrxxxY7iIHzaGE2y7KTGaYuhd9xxogwI+GeyAgUtcs4tOTcEjp6K",
  render_errors: [view: Scanner.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scanner.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
import_config "config.secret.exs"
