defmodule Supermarket.BasketAgentTest do
  @moduledoc false

  use ExUnit.Case

  alias Supermarket.{Basket, BasketAgent, Product}

  setup do
    Agent.update(BasketAgent, fn _ -> [] end)
    :ok
  end

  test "add basket and product to it" do
    basket_id = 1
    basket = %Basket{id: basket_id, products: []}

    BasketAgent.add_basket(basket)

    product = %Product{code: "A1", name: "Product_1", price: Decimal.new("0.1")}

    BasketAgent.add_product_to_basket(basket_id, product)

    assert [product] == BasketAgent.list_products_in_basket(basket_id)
  end

  test "list baskets" do
    basket_id = 2
    basket = %Basket{id: basket_id, products: []}

    BasketAgent.add_basket(basket)

    assert [basket] == BasketAgent.list_baskets()
  end

  test "remove product from basket" do
    basket_id = 3
    product_1 = %Product{code: "B1", name: "Product_1", price: Decimal.new("0.1")}
    product_2 = %Product{code: "B2", name: "Product_2", price: Decimal.new("0.1")}
    basket = %Basket{id: basket_id, products: [product_1, product_2]}

    BasketAgent.add_basket(basket)

    BasketAgent.remove_product_from_basket(basket_id, "B1")

    assert [product_2] == BasketAgent.list_products_in_basket(basket_id)
  end

  test "delete basket" do
    basket_id = 4
    basket = %Basket{id: basket_id, products: []}

    BasketAgent.add_basket(basket)

    BasketAgent.delete_basket(basket_id)

    assert [] == BasketAgent.list_baskets()
  end
end
