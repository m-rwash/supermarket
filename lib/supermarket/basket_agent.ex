defmodule Supermarket.BasketAgent do
  @moduledoc """
  This module defines an agent for managing baskets.
  """
  use Agent

  alias Supermarket.{Basket, Product}

  @spec start_link(any()) :: {:ok, pid()} | {:error, any()}
  def start_link(_initial_value) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  @spec add_basket(Basket.t()) :: :ok
  def add_basket(basket) do
    Agent.update(__MODULE__, fn baskets -> [basket | baskets] end)
  end

  @spec add_product_to_basket(integer(), Product.t()) :: :ok
  def add_product_to_basket(basket_id, product) do
    Agent.update(__MODULE__, fn baskets ->
      Enum.map(baskets, fn
        %Basket{id: ^basket_id} = basket ->
          %Basket{basket | products: [product | basket.products]}

        basket ->
          basket
      end)
    end)
  end

  @spec remove_product_from_basket(integer(), String.t()) :: :ok
  def remove_product_from_basket(basket_id, product_code) do
    Agent.update(__MODULE__, fn baskets ->
      Enum.map(baskets, fn
        %Basket{id: ^basket_id} = basket ->
          %Basket{
            basket
            | products:
                Enum.reject(basket.products, fn product -> product.code == product_code end)
          }

        basket ->
          basket
      end)
    end)
  end

  @spec list_products_in_basket(integer()) :: list(Product.t())
  def list_products_in_basket(basket_id) do
    Agent.get(__MODULE__, fn baskets ->
      get_basket_products(baskets, basket_id)
    end)
  end

  @spec list_baskets() :: list(Basket.t())
  def list_baskets do
    Agent.get(__MODULE__, fn baskets -> baskets end)
  end

  @spec delete_basket(integer()) :: :ok
  def delete_basket(basket_id) do
    Agent.update(__MODULE__, fn baskets ->
      Enum.reject(baskets, fn basket -> basket.id == basket_id end)
    end)
  end

  defp get_basket_products(baskets, basket_id) do
    case Enum.find(baskets, fn basket -> basket.id == basket_id end) do
      nil -> []
      basket -> basket.products
    end
  end
end
