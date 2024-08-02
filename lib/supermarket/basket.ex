defmodule Supermarket.Basket do
  @moduledoc """
  This module defines a basket struct.
  """

  @doc """
  Define a basket struct with required fields.

  ## Examples

      iex> %Supermarket.Basket{id: 1, products: ["product1", "product2"]}
      %Supermarket.Basket{id: 1, products: ["product1", "product2"]}
  """
  @enforce_keys [:id, :products]
  defstruct [:id, :products]
end
