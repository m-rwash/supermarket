defmodule Supermarket.Product do
  @moduledoc """
  This module defines a product struct.
  """
  @doc """
  Define a product struct with required and optional fields.

  ## Examples

      iex> %Supermarket.Product{code: "123", name: "Product"}
      %Supermarket.Product{code: "123", name: "Product", price: Decimal.new("0")}
  """

  @type t :: %__MODULE__{code: String.t(), name: String.t(), price: Decimal.t()}

  @enforce_keys [:code, :name]
  defstruct [:code, :name, price: Decimal.new(0)]
end
