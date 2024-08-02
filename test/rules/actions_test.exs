defmodule Supermarket.Rules.ActionsTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.{Actions, Basket, Product}

  doctest Supermarket.Actions

  describe "buy_one_get_one_free/1" do
    test "returns a function that will return a new list of products after applying buy one get one free" do
      product_1 = %Product{code: "123", name: "Product_1", price: Decimal.new("5")}
      product_2 = %Product{code: "123", name: "Product_1", price: Decimal.new("5")}
      product_3 = %Product{code: "456", name: "Product_2", price: Decimal.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2, product_3]}

      action = Actions.buy_one_get_one_free("123")

      assert MapSet.new(action.(basket.products)) ==
               MapSet.new([
                 %Product{code: "123", name: "Product_1", price: Decimal.new("5")},
                 %Product{code: "123", name: "Product_1", price: Decimal.new("0")},
                 %Product{code: "456", name: "Product_2", price: Decimal.new("4")}
               ])
    end

    test "returns a function that will return an empty list if no products are eligible for buy one get one free" do
      product_1 = %Product{code: "123", name: "Product_1", price: Decimal.new("5")}
      product_2 = %Product{code: "123", name: "Product_1", price: Decimal.new("5")}
      product_3 = %Product{code: "456", name: "Product_2", price: Decimal.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2, product_3]}

      action = Actions.buy_one_get_one_free("789")

      assert action.(basket.products) == [
               %Product{code: "123", name: "Product_1", price: Decimal.new("5")},
               %Product{code: "123", name: "Product_1", price: Decimal.new("5")},
               %Product{code: "456", name: "Product_2", price: Decimal.new("4")}
             ]
    end
  end
end
