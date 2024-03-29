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

      prepare fn query, context ->
        case Ash.Query.get_argument(query, :tenant) do
          tenant when is_binary(tenant) ->
            pid = Dyndb.Repo.get_connection!(tenant)
            Dyndb.DynamicRepoTracer.set_span_context({Dyndb.Repo, pid})
          _ -> :ok
        end

        query
      end
    end

    action :count, :integer do
      primary? true
      argument :tenant, :string, allow_nil?: false

      run fn input, context ->
        tenant = Ash.ActionInput.get_argument(input, :tenant)
        count = __MODULE__
        |> Ash.Query.for_read(:read, %{tenant: tenant})
        |> Dyndb.Gadget.count

        count
      end
    end
  end

  code_interface do
    define_for Dyndb.Gadget

    define :read, args: [:tenant]
    define :count, action: :count, args: [:tenant]
  end

  attributes do
    uuid_primary_key :id
    attribute :model_name, :string
  end
end
