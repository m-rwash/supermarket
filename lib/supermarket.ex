defmodule Supermarket do
  @moduledoc """
  Documentation for `Supermarket`.
  """

  alias Decimal, as: D

  def checkout(%{products: products}) do
    products
    |> Enum.reduce(D.new(0), fn product, acc -> D.add(acc, product.price) end)
    |> D.to_string()
  end
end
