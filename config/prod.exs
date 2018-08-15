use Mix.Config

config :libguru, LibguruWeb.Endpoint,
  load_from_system_env: true,
  server: true,
  secret_key_base: "${SECRET_KEY_BASE}",
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :libguru, Libguru.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "${DATABASE_URL}",
  database: "",
  ssl: true,
  pool_size: 1 # free tier db only allows 1 connection
