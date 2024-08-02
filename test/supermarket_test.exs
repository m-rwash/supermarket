defmodule SupermarketTest do
  @moduledoc false
  use ExUnit.Case

  describe "checkout/1" do
    test "calculate checkout price for passed basket" do
      product_1 = %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("0.1")}
      product_2 = %Supermarket.Product{code: "456", name: "Product_2", price: Decimal.new("0.2")}
      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      assert Supermarket.checkout(basket) == "0.3"
    end
  end
end
