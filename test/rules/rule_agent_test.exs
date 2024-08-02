defmodule Supermarket.Rules.RuleAgentTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.Rules.{Actions, Conditions, Rule, RuleAgent}

  test "list initial default rules" do
    assert RuleAgent.list_rules() == [
             %Rule{
               id: 1,
               condition: Conditions.buy_n_or_more("GR1", 2),
               action: Actions.buy_one_get_one_free("GR1")
             }
           ]
  end

  test "add and list rules" do
    rule = %Rule{id: 1, condition: "condition", action: "action"}
    RuleAgent.add_rule(rule)
    assert Enum.member?(RuleAgent.list_rules(), rule) == true
  end

  test "delete rule" do
    rule = %Rule{id: 1, condition: "condition", action: "action"}
    RuleAgent.add_rule(rule)
    RuleAgent.delete_rule(1)
    assert RuleAgent.list_rules() == []
  end
end
