defmodule Supermarket.ProductAgentTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.ProductAgent

  setup do
    Agent.update(ProductAgent, fn _ -> [] end)
    :ok
  end

  test "add and list products" do
    product = %Supermarket.Product{code: "A1", name: "Product_1", price: Decimal.new("0.1")}
    ProductAgent.add_product(product)
    assert ProductAgent.list_products() == [product]
  end

  test "delete product" do
    product = %Supermarket.Product{code: "A1", name: "Product_1", price: Decimal.new("0.1")}
    ProductAgent.add_product(product)
    ProductAgent.delete_product("A1")
    assert ProductAgent.list_products() == []
  end
end
