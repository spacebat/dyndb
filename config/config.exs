import Config

config :dyndb, :ash_apis, [Dyndb.Gadget]

config :dyndb, :ecto_repos, [Dyndb.Repo]

config :dyndb, :tenants, ["tenant1", "tenant2"]

config :ash, tracer: [Dyndb.DynamicRepoTracer]

import_config "#{config_env()}.exs"
