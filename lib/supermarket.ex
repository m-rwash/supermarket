defmodule Supermarket do
  @moduledoc """
  Documentation for `Supermarket`.
  """

  alias Supermarket.{Basket, BasketAgent, Checkout, Product, ProductAgent}
  alias Supermarket.Rules.{Rule, RuleAgent}

  @spec list_rules() :: [Rule.t()]
  def list_rules, do: RuleAgent.list_rules()
  def add_rule(rule), do: RuleAgent.add_rule(rule)
  @spec delete_rule(integer()) :: :ok
  def delete_rule(id), do: RuleAgent.delete_rule(id)

  @spec list_products() :: [Product.t()]
  def list_products, do: ProductAgent.list_products()
  @spec add_product(Product.t()) :: :ok
  def add_product(product), do: ProductAgent.add_product(product)
  @spec delete_product(String.t()) :: :ok
  def delete_product(code), do: ProductAgent.delete_product(code)

  @spec list_baskets() :: [Basket.t()]
  def list_baskets, do: BasketAgent.list_baskets()
  @spec add_basket(Basket.t()) :: :ok
  def add_basket(basket), do: BasketAgent.add_basket(basket)
  @spec delete_basket(any()) :: :ok
  def delete_basket(id), do: BasketAgent.delete_basket(id)
  @spec add_product_to_basket(integer(), Product.t()) :: :ok
  def add_product_to_basket(basket_id, product),
    do: BasketAgent.add_product_to_basket(basket_id, product)

  @spec remove_product_from_basket(integer(), String.t()) :: :ok
  def remove_product_from_basket(basket_id, product_code),
    do: BasketAgent.remove_product_from_basket(basket_id, product_code)

  @spec checkout(Supermarket.Basket.t()) :: String.t()
  def checkout(basket), do: Checkout.run(basket)
end
