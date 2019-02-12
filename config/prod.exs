use Mix.Config

config :libguru, LibguruWeb.Endpoint,
  load_from_system_env: true,
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "libguru.internal.devguru.co", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :libguru, Libguru.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("POSTGRES_DB"),
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: System.get_env("POSTGRES_HOST"),
  pool_size: 1 # free tier db only allows 1 connection
