defmodule Supermarket.ProductTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.Product
  doctest Supermarket.Product

  test "creating product with required fields" do
    product = %Product{code: "123", name: "Product"}
    assert product.code == "123"
    assert product.name == "Product"
  end

  test "creating product with optional fields" do
    product = %Product{code: "123", name: "Product", price: Decimal.new(10)}
    assert product.code == "123"
    assert product.name == "Product"
    assert product.price == Decimal.new(10)
  end

  test "creating product with default price" do
    product = %Product{code: "123", name: "Product"}
    assert product.price == Decimal.new(0)
  end
end
