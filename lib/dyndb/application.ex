defmodule Dyndb.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # This can't connect as there is no "default" tenant
      # Dyndb.Repo
    ]

    opts = [strategy: :one_for_one, name: Dyndb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
