defmodule SupermarketTest do
  @moduledoc false
  use ExUnit.Case

  alias Supermarket.Rules.{Actions, Conditions, Rule, RuleAgent}

  doctest Supermarket

  describe "checkout/1" do
    test "calculate checkout price for passed basket" do
      product_1 = %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("0.1")}
      product_2 = %Supermarket.Product{code: "456", name: "Product_2", price: Decimal.new("0.2")}
      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      assert Supermarket.checkout(basket) == "0.3"
    end

    test "calculate checkout price for empty basket" do
      basket = %Supermarket.Basket{id: 1, products: []}

      assert Supermarket.checkout(basket) == "0"
    end

    test "calculate checkout price for basket with one product" do
      product = %Supermarket.Product{code: "123", name: "Product", price: Decimal.new("0.1")}
      basket = %Supermarket.Basket{id: 1, products: [product]}

      assert Supermarket.checkout(basket) == "0.1"
    end

    test "calculate checkout price for basket when rule applies" do
      product_1 = %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("4.5")}
      product_2 = %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("4.5")}

      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      RuleAgent.add_rule(%Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("123", 2),
        action: Actions.buy_one_get_one_free("123")
      })

      assert Supermarket.checkout(basket) == "4.5"
    end
  end
end
