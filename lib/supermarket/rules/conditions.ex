defmodule Supermarket.Rules.Conditions do
  @moduledoc """
  This module defines possible conditions for rules that can be applied to a basket i.e. buy 3 or more products.
  """

  alias Supermarket.Product

  @doc """
  This function returns a function that will return true if the number of products in the basket is greater than or equal to n.

  ## Examples

      iex> condition = Supermarket.Rules.Conditions.buy_n_or_more("123", 2)
      ...> condition.([%Product{code: "123", name: "Product_1", price: Decimal.new("5")}, %Product{code: "123", name: "Product_1", price: Decimal.new("5")}])
      true
  """
  @spec buy_n_or_more(String.t(), integer()) :: (list(Product.t()) -> boolean())
  def buy_n_or_more(product_code, n) do
    fn basket ->
      count = Enum.count(basket, fn product -> product.code == product_code end)
      count >= n
    end
  end
end
