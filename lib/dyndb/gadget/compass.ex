defmodule Dyndb.Gadget.Compass do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  require Logger

  postgres do
    table "compasses"
    repo Dyndb.Repo
  end

  actions do
    read :read do
      primary? true
      argument :tenant, :string, allow_nil?: false

      # This doesn't work because `put_dynamic_repo` is process-local, and the query handling
      # crosses processes.
      prepare fn query, _context ->
        if %{arguments: %{tenant: tenant}} = query do
          pid = Dyndb.Repo.get_connection!(tenant)
          Dyndb.Repo.put_dynamic_repo(pid)
          Ash.set_context(%{dynamic_repo_module: Dyndb.Repo})
        end

        query
      end
    end
  end

  code_interface do
    define_for Dyndb.Gadget

    define :read, args: [:tenant]
  end

  attributes do
    uuid_primary_key :id
    attribute :model_name, :string
  end
end
