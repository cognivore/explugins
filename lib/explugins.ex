defmodule Explugins do
  @moduledoc """
  Documentation for `Explugins`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Explugins.hello()
      :world

  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Explugins.Srv, []}
    ]

    opts = [strategy: :one_for_one, name: Explugins.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def hello do
    :world
  end
end
