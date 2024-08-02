defmodule Supermarket do
  @moduledoc """
  Documentation for `Supermarket`.
  """

  alias Decimal, as: D

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
  @spec checkout(Supermarket.Basket.t()) :: String.t()
  def checkout(%{products: products}) do
    products
    |> Enum.reduce(D.new(0), fn product, acc -> D.add(acc, product.price) end)
    |> D.to_string()
  end
end
