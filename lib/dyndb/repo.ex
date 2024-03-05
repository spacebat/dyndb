defmodule Dyndb.Repo do
  @moduledoc """
  Resources backed by this module must implement
  all actions to require the argument :tenant.

      actions do
        read :read do
          argument :tenant, :string, allow_nil? false
        end
      end
  """
  use AshPostgres.Repo, otp_app: :dyndb
  require Logger

  def get_connection(tenant) do
    Logger.debug("Getting connection for tenant #{tenant}...")

    repo_name = {:global, tenant}

    case __MODULE__.start_link(name: repo_name, database: tenant) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Logger.debug("Connection already exists for tenant #{tenant}")
        {:ok, pid}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_connection!(tenant) do
    case get_connection(tenant) do
      {:ok, repo} -> repo
      {:error, reason} -> raise reason
    end
  end
end
