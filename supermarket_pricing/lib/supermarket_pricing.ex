defmodule SupermarketPricing do
  @moduledoc """
  Documentation for `SupermarketPricing`.
  """

  @doc """
  Endpoints for `SupermarketPricing`.

  # TODO
  Products sold by pound should also be purchasable in ounces.
  - Single item for $0.65
  - Three items for $1
  - $1.99 per pound, purchase in fractional pounds is possible.
  - Two items for $3, buy two get one free, not necessarily buying in pairs. In this case, the price is $1.5 per item.
  """
  def start do
    products = [
      %Product{name: "Peanut Can", price: Decimal.new(0.65), price_type: :unit},
      %Product{name: "Apple", price: Decimal.new(1), price_type: :unit},
      %Product{name: "Banana", price: Decimal.new(1.99), price_type: :unit},
      %Product{name: "Shampoo", price: Decimal.new(3), price_type: :unit}
    ]

    IO.puts "Product List:"
    products
    |> Enum.each(&print_product/1)
  end

  defp print_product(product) do
    IO.puts "#{product.name} - #{product.price} - #{product.price_type}"
  end
end
