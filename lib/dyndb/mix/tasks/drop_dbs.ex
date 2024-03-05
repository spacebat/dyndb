defmodule Mix.Tasks.Dyndb.DropDbs do
  @moduledoc "Initialize the dyndb database(s)"
  use Mix.Task

  require Logger

  @shortdoc "Drop databases for switching tenants"
  def run(_args) do
    drop_dbs()
  end

  def drop_dbs() do
    conf =
      Application.get_env(:dyndb, Dyndb.Repo)
      |> Keyword.take([:hostname, :username, :password, :database])

    Application.fetch_env!(:dyndb, :tenants)
    |> Enum.each(fn tenant ->
      conf = Keyword.merge(conf, database: "postgres")
      run_sql("drop database #{tenant}", conf)
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
