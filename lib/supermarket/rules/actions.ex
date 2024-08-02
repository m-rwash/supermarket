defmodule Supermarket.Rules.Actions do
  @moduledoc """
  This module defines possible actions for rules that can be applied to a basket i.e. buy one get one free.
  """
  alias Decimal, as: D
  alias Supermarket.Product

  @two_thirds D.new("0.6667")

  @doc """
  This function returns a function that will return a new list of products after applying buy one get one free.

  ## Examples

      iex> action = Supermarket.Rules.Actions.buy_one_get_one_free("123")
      ...> action.([%Product{code: "123", name: "Product_1", price: D.new("5")}, %Supermarket.Product{code: "123", name: "Product_1", price: D.new("5")}])
      [
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("5")},
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("0")}
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

  @doc """
  This function returns a function that will return a new list of products with updating the price of passed product code.

  ## Examples

      iex> action = Supermarket.Rules.Actions.discount_product_price("123", D.new("2"))
      ...> action.([%Product{code: "123", name: "Product_1", price: D.new("5")}, %Product{code: "123", name: "Product_1", price: D.new("5")}])
      [
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("2")},
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("2")}
      ]
  """

  @spec discount_product_price(String.t(), D.t()) :: (list(Product.t()) ->
                                                        list(Product.t()))
  def discount_product_price(product_code, new_price) do
    fn basket ->
      Enum.map(basket, &update_product_price(&1, product_code, D.new(new_price)))
    end
  end

  @doc """
  This function returns a function that will return a new list of products with discounting the price to two thirds of passed product code.

  ## Examples

      iex> action = Supermarket.Rules.Actions.discount_two_thirds_product_price("123")
      ...> action.([%Product{code: "123", name: "Product_1", price: D.new("5")}, %Product{code: "123", name: "Product_1", price: D.new("5")}])
      [
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("3.3335")},
        %Supermarket.Product{code: "123", name: "Product_1", price: D.new("3.3335")}
      ]
  """
  @spec discount_two_thirds_product_price(String.t()) :: (list(Product.t()) -> list(Product.t()))
  def discount_two_thirds_product_price(product_code) do
    fn basket ->
      Enum.map(
        basket,
        &update_product_price(&1, product_code, D.mult(&1.price, @two_thirds))
      )
    end
  end

  @spec apply_buy_one_get_one_discount(list(Product.t())) :: list(Product.t())
  defp apply_buy_one_get_one_discount(products) do
    Enum.with_index(products)
    |> Enum.map(fn {product, index} ->
      if rem(index, 2) == 1 do
        %Product{product | price: D.new(0)}
      else
        product
      end
    end)
  end

  @spec update_product_price(Product.t(), String.t(), D.t()) :: Product.t()
  defp update_product_price(product, product_code, new_price) do
    if product.code == product_code do
      %Product{product | price: new_price}
    else
      product
    end
  end
end
