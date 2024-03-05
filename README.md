# Dyndb

Experiment in Ash multi-tenancy by switching between databases/connections.

## Getting Started

0. Postgresql listening on localhost:5432 with user postgres, pass postgres, failing that you'll need to edit `config/dev.exs`

1. Clone the git repo to a directory, say dyndb:

`git clone https://github.com/spacebat/dyndb.git`

`cd dyndb`

`mix deps.get`

2. Ceate 2 databases in local postgres, "tenant1" and "tenant2"

`mix dyndb.create_dbs`

3. run IEx to try to figure out how to do multi-tenancy

`iex -S mix`

```
iex> Compass.read!("tenant1")

00:52:31.934 [debug] Getting connection for tenant tenant1...

00:52:31.993 [debug] Connection obtained tenant tenant1: #PID<0.274.0>

00:52:31.993 [debug] Connection #PID<0.274.0> set on #PID<0.273.0> for tenant tenant1
** (RuntimeError) could not lookup Ecto repo Dyndb.Repo because it was not started or it does not exist
    (ecto 3.11.1) lib/ecto/repo/registry.ex:22: Ecto.Repo.Registry.lookup/1
    (ecto 3.11.1) lib/ecto/repo/transaction.ex:39: Ecto.Repo.Transaction.in_transaction?/1
    (ash 2.19.14) lib/ash/actions/helpers.ex:7: Ash.Actions.Helpers.rollback_if_in_transaction/3
    (ash 2.19.14) lib/ash/actions/read/read.ex:2001: Ash.Actions.Read.run_query/4
    (ash 2.19.14) lib/ash/actions/read/read.ex:390: anonymous fn/5 in Ash.Actions.Read.do_read/4
    (ash 2.19.14) lib/ash/engine/engine.ex:514: anonymous fn/4 in Ash.Engine.async/2
    (elixir 1.16.1) lib/task/supervised.ex:101: Task.Supervised.invoke_mfa/2
    iex:1: (file)
```
