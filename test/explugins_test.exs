defmodule ExpluginsTest do
  use ExUnit.Case
  doctest Explugins

  test "greets the world" do
    assert Explugins.hello() == :world
  end
end
