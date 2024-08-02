defmodule Supermarket.Rules.RuleAgentTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.Rules.{Rule, RuleAgent}

  setup do
    Agent.update(RuleAgent, fn _ -> [] end)
    :ok
  end

  test "add and list rules" do
    rule = %Rule{id: 1, condition: "condition", action: "action"}
    RuleAgent.add_rule(rule)
    assert RuleAgent.list_rules() == [rule]
  end

  test "delete rule" do
    rule = %Rule{id: 1, condition: "condition", action: "action"}
    RuleAgent.add_rule(rule)
    RuleAgent.delete_rule(1)
    assert RuleAgent.list_rules() == []
  end
end
