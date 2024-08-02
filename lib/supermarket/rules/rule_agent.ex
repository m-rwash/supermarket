defmodule Supermarket.Rules.RuleAgent do
  @moduledoc """
  This module defines a rule agent to add, list and delete rules.
  """
  use Agent

  alias Decimal, as: D
  alias Supermarket.Rules.{Actions, Conditions, Rule}

  @spec start_link(any()) :: {:ok, pid()} | {:error, any()}
  def start_link(_initial_value) do
    initial_rules = [
      %Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("GR1", 2),
        action: Actions.buy_one_get_one_free("GR1")
      },
      %Rule{
        id: 2,
        condition: Conditions.buy_n_or_more("SR1", 3),
        action: Actions.discount_product_price("SR1", D.new("4.5"))
      },
      %Rule{
        id: 3,
        condition: Conditions.buy_n_or_more("CF1", 3),
        action: Actions.discount_two_thirds_product_price("CF1")
      }
    ]

    Agent.start_link(fn -> initial_rules end, name: __MODULE__)
  end

  @spec add_rule(Rule.t()) :: :ok
  def add_rule(rule) do
    Agent.update(__MODULE__, fn rules -> [rule | rules] end)
  end

  @spec list_rules() :: list(Rule.t())
  def list_rules do
    Agent.get(__MODULE__, fn rules -> rules end)
  end

  @spec delete_rule(integer()) :: :ok
  def delete_rule(rule_id) do
    Agent.update(__MODULE__, fn rules ->
      Enum.reject(rules, fn rule -> rule.id == rule_id end)
    end)
  end
end
