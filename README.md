# Dyndb

Experiment in Ash multi-tenancy by switching between databases/connections.

## Installation

Clone the git repo to a directory, say dyndb

cd dyndb

mix deps.get

# create 2 databases in local postgres, "tenant1" and "tenant2"
mix dyndb.create_dbs

# run IEx to try to figure out how to do multi-tenancy
`iex -S mix`

```
iex(iex@medusa)2> Compass.read!("tenant1")
query: #Ash.Query<resource: Dyndb.Gadget.Compass, arguments: %{tenant: "tenant1"}>

00:25:33.672 [debug] Getting connection for tenant tenant1...
** (RuntimeError) could not lookup Ecto repo Dyndb.Repo because it was not started or it does not exist
    (ecto 3.11.1) lib/ecto/repo/registry.ex:22: Ecto.Repo.Registry.lookup/1
    (ecto 3.11.1) lib/ecto/repo/transaction.ex:39: Ecto.Repo.Transaction.in_transaction?/1
    (ash 2.19.14) lib/ash/actions/helpers.ex:7: Ash.Actions.Helpers.rollback_if_in_transaction/3
    (ash 2.19.14) lib/ash/actions/read/read.ex:2001: Ash.Actions.Read.run_query/4
    (ash 2.19.14) lib/ash/actions/read/read.ex:390: anonymous fn/5 in Ash.Actions.Read.do_read/4
    (ash 2.19.14) lib/ash/engine/engine.ex:514: anonymous fn/4 in Ash.Engine.async/2
    (elixir 1.16.1) lib/task/supervised.ex:101: Task.Supervised.invoke_mfa/2
    iex:2: (file)
```
