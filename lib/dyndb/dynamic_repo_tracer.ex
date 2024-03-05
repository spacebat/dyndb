defmodule Dyndb.DynamicRepoTracer do
  @moduledoc """
  Piggy-back Ecto dynamic repo information on Ash.Tracer span context, which is transferred between
  processes and can be acted on in the new process when it calles `set_span_context/1`.
  """
  use Ash.Tracer

  @impl Ash.Tracer
  def get_span_context() do
    Process.get(:dynamic_repo_tracer)
  end

  @impl Ash.Tracer
  def set_span_context({repo_module, repo_pid} = dynamic_repo) do
    Process.put(:dynamic_repo_tracer, dynamic_repo)
    repo_module.put_dynamic_repo(repo_pid)
    :ok
  end

  def set_span_context(_context), do: :ok

  @impl Ash.Tracer
  def start_span(_span_type, _name) do
    :ok
  end

  @impl Ash.Tracer
  def stop_span() do
    :ok
  end

  @impl Ash.Tracer
  def set_metadata(_span_type, _metadata) do
    :ok
  end

  @impl Ash.Tracer
  def set_error(_exception, _opts \\ []) do
    :ok
  end
end
