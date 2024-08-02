defmodule Supermarket.Rules.ActionsTest do
  @moduledoc false

  use ExUnit.Case

  alias Decimal, as: D
  alias Supermarket.{Basket, Product}
  alias Supermarket.Rules.Actions

  doctest Supermarket.Rules.Actions

  describe "buy_one_get_one_free/1" do
    test "returns a function that will return a new list of products after applying buy_one_get_one_free" do
      product_1 = %Product{code: "A1", name: "Product_1", price: D.new("5")}
      product_2 = %Product{code: "A1", name: "Product_1", price: D.new("5")}
      product_3 = %Product{code: "B1", name: "Product_2", price: D.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2, product_3]}

      action = Actions.buy_one_get_one_free("A1")

      assert MapSet.new(action.(basket.products)) ==
               MapSet.new([
                 %Product{code: "A1", name: "Product_1", price: D.new("5")},
                 %Product{code: "A1", name: "Product_1", price: D.new("0")},
                 %Product{code: "B1", name: "Product_2", price: D.new("4")}
               ])
    end

    test "returns a function that will return unchanged basket if no products are eligible for buy_one_get_one_free" do
      product_1 = %Product{code: "A2", name: "Product_1", price: D.new("5")}
      product_2 = %Product{code: "A2", name: "Product_1", price: D.new("5")}
      product_3 = %Product{code: "B2", name: "Product_2", price: D.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2, product_3]}

      action = Actions.buy_one_get_one_free("789")

      assert action.(basket.products) == [
               %Product{code: "A2", name: "Product_1", price: D.new("5")},
               %Product{code: "A2", name: "Product_1", price: D.new("5")},
               %Product{code: "B2", name: "Product_2", price: D.new("4")}
             ]
    end

    test "returns a function that will return a new list of products after applying new price for discount_product_price" do
      product_1 = %Product{code: "C1", name: "Product_1", price: D.new("5")}
      product_2 = %Product{code: "C2", name: "Product_2", price: D.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2]}

      action = Actions.discount_product_price("C1", D.new("3"))

      assert MapSet.new(action.(basket.products)) ==
               MapSet.new([
                 %Product{code: "C1", name: "Product_1", price: D.new("3")},
                 %Product{code: "C2", name: "Product_2", price: D.new("4")}
               ])
    end

    test "returns a function that will return unchanged basket if no products are eligible for discount_product_price" do
      product_1 = %Product{code: "D1", name: "Product_1", price: D.new("5")}
      product_2 = %Product{code: "D2", name: "Product_2", price: D.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2]}

      action = Actions.discount_product_price("D3", D.new("3"))

      assert action.(basket.products) == [
               %Product{code: "D1", name: "Product_1", price: D.new("5")},
               %Product{code: "D2", name: "Product_2", price: D.new("4")}
             ]
    end

    test "returns a function that will return a new list of products after applying new price for discount_two_thirds_product_price" do
      product_1 = %Product{code: "C1", name: "Product_1", price: D.new("5")}
      product_2 = %Product{code: "C2", name: "Product_2", price: D.new("4")}
      basket = %Basket{id: 1, products: [product_1, product_2]}

      action = Actions.discount_two_thirds_product_price("C1")

      assert MapSet.new(action.(basket.products)) ==
               MapSet.new([
                 %Product{code: "C1", name: "Product_1", price: D.new("3.33")},
                 %Product{code: "C2", name: "Product_2", price: D.new("4")}
               ])
    end
  end
end
