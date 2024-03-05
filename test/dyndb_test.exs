defmodule DyndbTest do
  use ExUnit.Case
  doctest Dyndb

  test "greets the world" do
    assert Dyndb.hello() == :world
  end
end
