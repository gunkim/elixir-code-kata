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
      Product.create_single("Peanut Can", Decimal.new("0.65")),
      Product.create_bundle("Apple", Decimal.new("1"), 3),
      Product.create_found("Banana", Decimal.new("1.99"), 1),
      Product.create_single("Shampoo", Decimal.new("1.5"))
    ]

    IO.puts "Product List:"
    products
    |> Enum.each(&print_product/1)
  end

  defp print_product(product) do
    IO.puts "#{product.name} - #{product.price} - #{product.price_type} - #{product.count}"
  end
end
