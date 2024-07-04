defmodule Explugins.Srv do
  @moduledoc """
  Demo of a GenServer that dispatches requests to one of three handlers:any()
   
   1. Handler that does routine checks;
   2. Handler that uses plugin from ./priv/a/flags.exs;
   3. Handler that uses plugin from ./priv/b/flags.exs;
  """

  use GenServer

  def init_modules_call_once!() do
    # For each directory $dir in priv, 
    # We check if the module $Dir.Flags is loaded.
    # If it is, we crash (or send mail, lol).
    # If it isn't, we load it with Code.comile_file "./priv/$dir/flags.exs". 

    priv_children = File.ls!("./priv")

    for dir <- priv_children do
      dir_caps = String.capitalize(dir)
      plugin_atom = String.to_atom("#{dir_caps}.Flags")

      if Code.ensure_loaded?(plugin_atom) do
        throw("Plugin #{dir_caps} is already loaded.")
      else
        IO.puts("Loading plugin #{dir_caps}.")
        # May throw if compilation fails?
        [] = Code.compile_file("./priv/#{dir}/flags.exs")
      end
    end
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    {:ok, []}
  end

  def handle_call(x, state) when is_atom(x) do
    # Convert atom x to string
    x_caps = to_string(x) |> String.capitalize()
    plugin_atom = String.to_atom("${x_caps}.Flags")
    # MFA-call plugin_atom's "callback" function
  end
end
