import Config

config :dyndb, Dyndb.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "postgres",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
