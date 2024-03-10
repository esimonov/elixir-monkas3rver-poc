defmodule POCServiceTest do
  use ExUnit.Case
  doctest POCService

  test "greets the world" do
    assert POCService.hello() == :world
  end
end
