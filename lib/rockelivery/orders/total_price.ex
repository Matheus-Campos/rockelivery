defmodule Rockelivery.Orders.TotalPrice do
  alias Rockelivery.Item

  def calculate(items), do: calculate(items, Decimal.new("0.00"))

  def calculate([%Item{price: price} | tail], acc) do
    calculate(tail, Decimal.add(acc, price))
  end

  def calculate([], acc), do: acc
end
