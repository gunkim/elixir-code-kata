  defmodule SupermarketPricing do
    @moduledoc """
    Documentation for `SupermarketPricing`.
    """

    @doc """
    Endpoints for `SupermarketPricing`.

    # TODO
    Products sold by pound should also be purchasable in ounces.
    - Two items for $3, buy two get one free, not necessarily buying in pairs. In this case, the price is $1.5 per item.
    """
    def start do
      products = [
        Product.create_single("Peanut Can", Decimal.new("0.65")),
        Product.create_bundle("Apple", Decimal.new("1"), 3),
        Product.create_found("Banana", Decimal.new("1.99"), 1),
        Product.create_single("Shampoo", Decimal.new("1.5"))
      ]

      IO.puts "========== Product List =========="
      products
      |> Enum.each(&Product.print_product/1)
      IO.puts("=======================")

      selected_product = IO.gets("Enter product name: ")
                         |> String.trim()
                         |> (&Products.search(products, &1)).()

      IO.puts "Information of the product you want to buy:"
      Product.print_product(selected_product)

      IO.puts "Please enter the quantity and price you want to buy:"
      purchase_quantity_or_price = IO.gets("Input count or price or weight: ")
                                   |> String.trim()
                                   |> Decimal.new()

      result = Product.price(selected_product, purchase_quantity_or_price)
      IO.puts "Total Price: #{Decimal.to_string(result)}"
    end
end