defmodule Supermarket.Rule do
  @moduledoc """
  This module defines a rule struct.
  """

  @doc """
  Define a rule struct with required fields.

  ## Examples

      iex> %Supermarket.Rule{id: 1, condition: "condition", action: "action"}
      %Supermarket.Rule{id: 1, condition: "condition", action: "action"}
  """
  @enforce_keys [:id, :condition, :action]
  defstruct [:id, :condition, :action]
end
