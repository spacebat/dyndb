defmodule Mix.Tasks.Dyndb.CreateDbs do
  @moduledoc "Initialize the dyndb database(s)"
  use Mix.Task

  require Logger

  @shortdoc "Create databases for switching tenants"
  def run(_args) do
    create_dbs()
  end

  def create_dbs() do
    conf =
      Application.get_env(:dyndb, Dyndb.Repo)
      |> Keyword.take([:hostname, :username, :password, :database])

    Application.fetch_env!(:dyndb, :tenants)
    |> Enum.each(fn tenant ->
      conf = Keyword.merge(conf, database: "postgres")
      run_sql("create database #{tenant}", conf)
      conf = Keyword.merge(conf, database: tenant)
      [
        "create table if not exists compasses (id uuid primary key default gen_random_uuid(), name text)",
        "insert into compasses (name) values ('compass_in_#{tenant}')"
      ]
      |> Enum.each(fn sql -> run_sql(sql, conf) end)
    end)
  end

  defp run_sql(sql, conf) do
    System.cmd("/usr/bin/env",
      [
        "PGPASSWORD=#{conf[:password]}",
        "psql",
        "-h", conf[:hostname],
        "-U", conf[:username],
        conf[:database],
        "-c",
        sql
      ]
    )
  end
end
