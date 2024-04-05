defmodule ProductHelper do
  @doc """
    Converts a price to a dollar format.
  """
  def to_dollar(price) do
    "$#{Decimal.to_string(price)}"
  end
end

defprotocol Product do
  @fallback_to_any true

  @doc """
    Prints the product information.
  """
  def print_product(product)
  @doc """
    Calculates the price of the product.
  """
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
  defstruct [:name, :price, :found]
  defimpl Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Price: #{product.found} pounds for #{ProductHelper.to_dollar(product.price)} per unit"
    end

    def price(product, found) do
      effective_price = Decimal.mult(Decimal.new(product.price), Decimal.new(product.found))
      total_price = Decimal.mult(found, effective_price)

      Decimal.round(total_price, 2, :down)
    end
  end
end