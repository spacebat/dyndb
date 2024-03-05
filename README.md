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

3. Run IEx and try to figure out how to do multi-tenancy

`iex -S mix`

In the case below, the default tenant database named "postgres" is queried because the effects of `put_dynamic_repo` do not carry over to the process that performs the query. The default tenant does not have the "compasses" table.

```
iex> Compass.read!("tenant1")

01:22:38.335 [debug] Getting connection for tenant tenant1...

01:22:38.339 [debug] Connection obtained tenant tenant1: #PID<0.362.0>

01:22:38.340 [debug] Connection #PID<0.362.0> set on #PID<0.361.0> for tenant tenant1

01:22:38.379 [debug] QUERY ERROR source="compasses" db=0.7ms queue=3.0ms idle=912.7ms
SELECT c0."id", c0."name" FROM "compasses" AS c0 []
** (Ash.Error.Unknown) Unknown Error

* ** (Postgrex.Error) ERROR 42P01 (undefined_table) relation "compasses" does not exist

    query: SELECT c0."id", c0."name" FROM "compasses" AS c0
  (ecto_sql 3.11.1) lib/ecto/adapters/sql.ex:1054: Ecto.Adapters.SQL.raise_sql_call_error/1
  (ecto_sql 3.11.1) lib/ecto/adapters/sql.ex:952: Ecto.Adapters.SQL.execute/6
  (ecto 3.11.1) lib/ecto/repo/queryable.ex:232: Ecto.Repo.Queryable.execute/4
  (ecto 3.11.1) lib/ecto/repo/queryable.ex:19: Ecto.Repo.Queryable.all/3
  (ash_postgres 1.5.15) lib/data_layer.ex:701: anonymous fn/3 in AshPostgres.DataLayer.run_query/2
  (ash_postgres 1.5.15) lib/data_layer.ex:700: AshPostgres.DataLayer.run_query/2
  (ash 2.19.14) lib/ash/actions/read/read.ex:2000: Ash.Actions.Read.run_query/4
  (ash 2.19.14) lib/ash/actions/read/read.ex:390: anonymous fn/5 in Ash.Actions.Read.do_read/4
    (elixir 1.16.1) lib/process.ex:860: Process.info/2
    (ash 2.19.14) lib/ash/error/exception.ex:59: Ash.Error.Unknown."exception (overridable 2)"/1
    (ash 2.19.14) lib/ash/error/error.ex:600: Ash.Error.choose_error/2
    (ash 2.19.14) lib/ash/error/error.ex:260: Ash.Error.to_error_class/2
    (ash 2.19.14) lib/ash/actions/read/read.ex:281: Ash.Actions.Read.do_run/3
    (ash 2.19.14) lib/ash/actions/read/read.ex:49: anonymous fn/3 in Ash.Actions.Read.run/3
    (ash 2.19.14) lib/ash/actions/read/read.ex:48: Ash.Actions.Read.run/3
    iex:1: (file)
```
