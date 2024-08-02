defmodule Supermarket.Rules.ConditionsTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.{Basket, Product}
  alias Supermarket.Rules.Conditions

  doctest Supermarket.Rules.Conditions

  describe "buy_n_or_more/2" do
    test "returns a function that will return true if the number of products in the basket is greater than or equal to n" do
      product_1 = %Product{code: "A1", name: "Product_1", price: Decimal.new("5")}
      product_2 = %Product{code: "A1", name: "Product_1", price: Decimal.new("5")}
      basket = %Basket{id: 1, products: [product_1, product_2]}

      condition = Conditions.buy_n_or_more("A1", 2)

      assert condition.(basket.products) == true
    end

    test "returns a function that will return false if the number of products in the basket is less than n" do
      product_1 = %Product{code: "B1", name: "Product_1", price: Decimal.new("5")}
      product_2 = %Product{code: "B1", name: "Product_1", price: Decimal.new("5")}
      basket = %Basket{id: 1, products: [product_1, product_2]}

      condition = Conditions.buy_n_or_more("123", 3)

      assert condition.(basket.products) == false
    end
  end
end
