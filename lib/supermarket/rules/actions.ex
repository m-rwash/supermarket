defmodule Supermarket.Rules.Actions do
  @moduledoc """
  This module defines possible actions for rules that can be applied to a basket i.e. buy one get one free.
  """
  alias Supermarket.Product
  alias Decimal, as: D

  @doc """
  This function returns a function that will return a new list of products after applying buy one get one free.

  ## Examples

      iex> action = Supermarket.Actions.buy_one_get_one_free("123")
      ...> action.([%Product{code: "123", name: "Product_1", price: Decimal.new("5")}, %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("5")}])
      [
        %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("0")},
        %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("5")}
      ]
  """

  @spec buy_one_get_one_free(String.t()) :: (list(Product.t()) -> list(Product.t()))
  def buy_one_get_one_free(product_code) do
    fn basket ->
      {eligible, rest} = Enum.split_with(basket, fn product -> product.code == product_code end)

      discounted = apply_buy_one_get_one_discount(eligible)

      discounted ++ rest
    end
  end

  @spec apply_buy_one_get_one_discount(list(Product.t())) :: list(Product.t())
  defp apply_buy_one_get_one_discount(products) do
    Enum.map_every(products, 2, fn
      nil -> nil
      product -> %Product{product | price: D.new(0)}
    end)
  end
end
