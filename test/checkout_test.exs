defmodule Supermarket.CheckoutTest do
  @moduledoc false
  use ExUnit.Case

  alias Supermarket.Rules.{Actions, Conditions, Rule, RuleAgent}

  doctest Supermarket

  describe "run/1" do
    test "calculate checkout price for passed basket" do
      product_1 = %Supermarket.Product{code: "123", name: "Product_1", price: Decimal.new("0.1")}
      product_2 = %Supermarket.Product{code: "456", name: "Product_2", price: Decimal.new("0.2")}
      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      assert Supermarket.checkout(basket) == "0.30"
    end

    test "calculate checkout price for empty basket" do
      basket = %Supermarket.Basket{id: 1, products: []}

      assert Supermarket.checkout(basket) == "0.00"
    end

    test "calculate checkout price for basket with one product" do
      product = %Supermarket.Product{code: "123", name: "Product", price: Decimal.new("0.1")}
      basket = %Supermarket.Basket{id: 1, products: [product]}

      assert Supermarket.checkout(basket) == "0.10"
    end

    test "calculate checkout price for basket when rule buy_one_get_one_free applies" do
      product_1 = %Supermarket.Product{code: "A1", name: "Product_1", price: Decimal.new("4.5")}
      product_2 = %Supermarket.Product{code: "A1", name: "Product_1", price: Decimal.new("4.5")}
      product_3 = %Supermarket.Product{code: "A1", name: "Product_1", price: Decimal.new("4.5")}

      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2, product_3]}

      RuleAgent.add_rule(%Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("A1", 2),
        action: Actions.buy_one_get_one_free("A1")
      })

      assert Supermarket.checkout(basket) == "9.00"
    end

    test "calculate checkout price for basket when rule discount_product_price applies" do
      product_1 = %Supermarket.Product{code: "B1", name: "Product_1", price: Decimal.new("4.5")}
      product_2 = %Supermarket.Product{code: "B1", name: "Product_1", price: Decimal.new("4.5")}

      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      RuleAgent.add_rule(%Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("B1", 2),
        action: Actions.discount_product_price("B1", Decimal.new("3.5"))
      })

      assert Supermarket.checkout(basket) == "7.00"
    end

    test "calculate checkout price for basket when rule discount_product_price_two_thirds applies" do
      product_1 = %Supermarket.Product{code: "C1", name: "Product_1", price: Decimal.new("4.5")}
      product_2 = %Supermarket.Product{code: "C1", name: "Product_1", price: Decimal.new("4.5")}

      basket = %Supermarket.Basket{id: 1, products: [product_1, product_2]}

      RuleAgent.add_rule(%Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("C1", 2),
        action: Actions.discount_two_thirds_product_price("C1")
      })

      assert Supermarket.checkout(basket) == "6.00"
    end
  end
end
