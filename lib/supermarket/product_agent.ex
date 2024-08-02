defmodule Supermarket.ProductAgent do
  @moduledoc """
  This module defines an agent for managing products.
  """
  use Agent

  alias Decimal, as: D
  alias Supermarket.Product

  @spec start_link(any()) :: {:ok, pid()} | {:error, any()}
  def start_link(_initial_value) do
    initial_products = [
      %Product{code: "GR1", name: "Green Tea", price: D.new("3.11")},
      %Product{code: "SR1", name: "Strawberries", price: D.new("5.0")},
      %Product{code: "CF1", name: "Coffee", price: D.new("11.23")}
    ]

    Agent.start_link(fn -> initial_products end, name: __MODULE__)
  end

  @spec add_product(Product.t()) :: :ok
  def add_product(product) do
    Agent.update(__MODULE__, fn products -> [product | products] end)
  end

  @spec list_products() :: list(Product.t())
  def list_products do
    Agent.get(__MODULE__, fn products -> products end)
  end

  @spec delete_product(String.t()) :: :ok
  def delete_product(product_code) do
    Agent.update(__MODULE__, fn products ->
      Enum.reject(products, fn product -> product.code == product_code end)
    end)
  end
end
