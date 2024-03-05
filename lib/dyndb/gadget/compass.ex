defmodule Dyndb.Gadget.Compass do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

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
      prepare fn query, context ->
        case query do
          %{arguments: %{tenant: tenant}} ->
            pid = Dyndb.Repo.get_connection!(tenant)
            Dyndb.Repo.put_dynamic_repo(pid)
            query
          query ->
            query
        end
      end
    end
  end

  code_interface do
    define_for Dyndb.Gadget

    define :read, args: [:tenant]
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string
  end
end
