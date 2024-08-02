defmodule Supermarket.Rules.RuleTest do
  @moduledoc false

  use ExUnit.Case

  doctest Supermarket.Rules.Rule

  test "create rule with required fields" do
    rule = %Supermarket.Rules.Rule{id: 1, condition: "condition", action: "action"}
    assert rule.id == 1
    assert rule.condition == "condition"
    assert rule.action == "action"
  end
end
