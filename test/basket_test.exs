defmodule Supermarket.BasketTest do
  @moduledoc false
  use ExUnit.Case
  doctest Supermarket.Basket

  test "creating basket with required field" do
    basket = %Supermarket.Basket{id: 1, products: ["product1", "product2"]}
    assert basket.id == 1
    assert basket.products == ["product1", "product2"]
  end
end
