# Supermarket

## Overview

> A simple cashier function that adds products to a cart and displays the total price. Along with applying special condition, offers, or what so called 'Rules'


## Features

- Manage Products
- Manage Baskets
- Applying rules or discounts
- Calculate checkout price

## How?
- Storage
  I used agents to store data in memory instead of using a database, as agents provide a simple and lightweight way to manage state within a process
  - RuleAgent: Is responsible of storing and listing rules. It initializes with these rules by default
    ``` elixir
      %Rule{
        id: 1,
        condition: Conditions.buy_n_or_more("GR1", 2),
        action: Actions.buy_one_get_one_free("GR1")
      },
      %Rule{
        id: 2,
        condition: Conditions.buy_n_or_more("SR1", 3),
        action: Actions.discount_product_price("SR1", D.new("4.5"))
      },
      %Rule{
        id: 3,
        condition: Conditions.buy_n_or_more("CF1", 3),
        action: Actions.discount_two_thirds_product_price("CF1")
      }
    ```
  - ProductsAgent: Is responsible of storing, removing, and listing products. It initializes with these products by default
    ```elixir
      %Product{code: "GR1", name: "Green Tea", price: Decimal.new("3.11")},
      %Product{code: "SR1", name: "Strawberries", price: Decimal.new("5.0")},
      %Product{code: "CF1", name: "Coffee", price: Decimal.new("11.23")}
    ```
  - BasketAgent: Is responsible of storing/removing products in/from baskets, and listing them.
- Checkout Process
  The checkout process is based on set of rules. Each rule has condition and action.
  - Condition: Is a function that takes the basket of products as input and returns a boolean to determine if the rule should be applied or not
  - Action: Is  a function that takes the basket of products as input and returns an updated basket with the discount/offer applied
  - Checkout: Is a function applies the rules in the system to the basket and returned final price.

## Get up and running

### Prerequisites
- Elixir

### Setup
1. Clone the repo
2. Navigate to root directory of the repo
3. Install dependencies by running `mix deps.get`
4. Run tests `mix test`
5. Start the interactive shell by running `iex -S mix`

### Examples
- Listing Products
  ```shell
  iex(1)> [gr1 | [sr1 | [cf1 | _]]] = Supermarket.list_products
  [
    %Supermarket.Product{
      code: "GR1",
      name: "Green Tea",
      price: Decimal.new("3.11")
    },
    %Supermarket.Product{
      code: "SR1",
      name: "Strawberries",
      price: Decimal.new("5.0")
    },
    %Supermarket.Product{code: "CF1", name: "Coffee", price: Decimal.new("11.23")}
  ]
  ```

- Manage Baskets
  ```shell
  iex(2)> Supermarket.list_baskets
  []

  iex(3)> Supermarket.add_basket(%Supermarket.Basket{id: 1, products: [gr1, gr1, gr1, sr1, cf1]})
  :ok

  iex(4)> [basket] = Supermarket.list_baskets
  ```

- Listing Rules
  ```shell
  iex(5)> Supermarket.list_rules
  [
    %Supermarket.Rules.Rule{
      id: 1,
      condition: #Function<0.32859601/1 in Supermarket.Rules.Conditions.buy_n_or_more/2>,
      action: #Function<1.121100591/1 in Supermarket.Rules.Actions.buy_one_get_one_free/1>
    },
    %Supermarket.Rules.Rule{
      id: 2,
      condition: #Function<0.32859601/1 in Supermarket.Rules.Conditions.buy_n_or_more/2>,
      action: #Function<2.121100591/1 in Supermarket.Rules.Actions.discount_product_price/2>
    },
    %Supermarket.Rules.Rule{
      id: 3,
      condition: #Function<0.32859601/1 in Supermarket.Rules.Conditions.buy_n_or_more/2>,
      action: #Function<3.121100591/1 in Supermarket.Rules.Actions.discount_two_thirds_product_price/1>
    }
  ]
  ```

- Checkout
  ```shell
    iex(6)> Supermarket.checkout(basket)
    "22.45"
  ```
  