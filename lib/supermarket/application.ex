defmodule Supermarket.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  alias Supermarket.Rules.RuleAgent

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RuleAgent
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Supermarket.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
