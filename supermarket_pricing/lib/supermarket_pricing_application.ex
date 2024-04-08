defmodule SupermarketPricingApplication do
  @moduledoc """
  Documentation for `SupermarketPricing`.
  """

  alias Domain.{
    BundleProduct,
    FoundProduct,
    Product,
    Products,
    SingleProduct}

  @doc """
  Endpoints for `SupermarketPricing`.
  # TODO
  - Two items for $3, buy two get one free, not necessarily buying in pairs. In this case, the price is $1.5 per item.
  """
  def start do
    products = [
      %SingleProduct{name: "Peanut Can", price: Decimal.new("0.65")},
      %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3},
      %FoundProduct{name: "Banana", price: Decimal.new("1.99"), found: 4},
      %SingleProduct{name: "Shampoo", price: Decimal.new("1.5")}
    ]

    IO.puts "========== Product List =========="
    products |> Enum.each(&Product.print_product/1)
    IO.puts("=======================")

    selected_product =
      IO.gets("Enter product name: ")
      |> String.trim()
      |> (&Products.search(products, &1)).()

    IO.puts "Information of the product you want to buy:"
    Product.print_product(selected_product)

    IO.puts "Please enter the quantity or weight(found) you wish to purchase."

    purchase_quantity_or_weight =
      IO.gets("Input quantity or weight(found): ")
      |> String.trim()
      |> Decimal.new()

    result = Product.price(selected_product, purchase_quantity_or_weight)
    IO.puts "Total Price: #{Decimal.to_string(result)}"
  end
end