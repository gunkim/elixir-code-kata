defmodule ProductHelper do
  def to_dollar(price) do
    "$#{Decimal.to_string(price)}"
  end
end

defprotocol Product do
  @fallback_to_any true

  def print_product(product)
  def price(product, amount)
end

defmodule SingleProduct do
  defstruct [:name, :price]

  defimpl Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Per unit: #{ProductHelper.to_dollar(product.price)}"
    end

    def price(product, quantity), do: Decimal.mult(quantity, product.price)
  end
end

defmodule BundleProduct do
  defstruct [:name, :price, :bundle_size]

  defimpl Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Per bundle of #{product.bundle_size} units: #{ProductHelper.to_dollar(product.price)}"
    end

    def price(product, quantity) do
      Decimal.div(quantity, Decimal.new(product.bundle_size))
      |> Decimal.mult(product.price)
      |> Decimal.round(2)
    end
  end
end

defmodule FoundProduct do
  defstruct [:name, :price]

  defimpl Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Per pound: #{ProductHelper.to_dollar(product.price)}"
    end

    def price(product, weight), do: Decimal.mult(weight, product.price)
  end
end