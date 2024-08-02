defmodule Supermarket.Checkout do
  @moduledoc """
  This module to calculate price.
  """

  alias Decimal, as: D

  alias Supermarket.{Basket, Product}
  alias Supermarket.Rules.RuleAgent

  @doc """
  Calculate checkout price for passed basket

  ## Examples

      iex> Supermarket.checkout(%Supermarket.Basket{id: 1, products: [%Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("2.4")}, %Supermarket.Product{code: "456", name: "Product_2", price: Decimal.new("3.5")}]})
      "5.9"
      iex> Supermarket.checkout(%Supermarket.Basket{id: 1, products: [%Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("2.5")}]})
      "2.5"
      iex> Supermarket.checkout(%Supermarket.Basket{id: 1, products: []})
      "0"
  """
  @spec run(Basket.t()) :: String.t()
  def run(%{products: products}) do
    products
    |> apply_rules()
    |> Enum.reduce(D.new(0), fn product, acc -> D.add(acc, product.price) end)
    |> D.to_string()
  end

  @spec apply_rules(list(Product.t())) :: list(Product.t())
  def apply_rules(products) do
    rules = RuleAgent.list_rules()

    discounted_basket =
      Enum.reduce(rules, products, fn rule, acc ->
        if rule.condition.(acc) do
          rule.action.(acc)
        else
          acc
        end
      end)

    discounted_basket
  end
end
