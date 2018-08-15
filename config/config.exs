# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :libguru,
  ecto_repos: [Libguru.Repo],
  github_token: System.get_env("GITHUB_CLIENT_TOKEN")

# Configures the endpoint
config :libguru, LibguruWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h8fCFz8b2YU6VRI5IYzx4F1MrIysVqXVFizspegBECXXVY8BW6rJTao/6eGcbLas",
  render_errors: [view: LibguruWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Libguru.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures template engines
config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
