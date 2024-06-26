defmodule Domain.ProductHelper do
  @moduledoc """
    Module for the ProductHelper struct to model products.
  """

  @doc """
    Converts a price to a dollar format.

    ## Example
        iex> Domain.ProductHelper.to_dollar(Decimal.new("1.5"))
        "$1.5"
  """
  @spec to_dollar(Decimal.t) :: String.t
  def to_dollar(price) do
    "$#{Decimal.to_string(price)}"
  end
end

defprotocol Domain.Product do
  @moduledoc """
    Protocol for the Product struct to model products.
  """

  @fallback_to_any true

  @doc """
    Prints the product information.
  """
  @spec print_product(Product.t) :: :ok
  def print_product(product)

  @doc """
    Calculates the price of the product.
  """
  @spec price(Product.t, Decimal.t) :: Decimal.t
  def price(product, amount)
end

defmodule Domain.SingleProduct do
  @moduledoc """
    Module for the SingleProduct struct to model products.

    # Example
        iex> %SingleProduct{name: "Peanut Can", price: Decimal.new("0.65")}
        %SingleProduct{name: "Peanut Can", price: Decimal.new("0.65")}
  """

  defstruct [:name, :price]

  defimpl Domain.Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Per unit: #{Domain.ProductHelper.to_dollar(product.price)}"
    end

    def price(product, quantity), do: Decimal.mult(quantity, product.price)
  end
end

defmodule Domain.BundleProduct do
  @moduledoc """
    Module for the BundleProduct struct to model products.

    # Example
        iex> %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3}
        %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3}
  """

  defstruct [:name, :price, :bundle_size]

  defimpl Domain.Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Per bundle of #{product.bundle_size} units: #{Domain.ProductHelper.to_dollar(product.price)}"
    end

    def price(product, quantity) do
      Decimal.div(quantity, Decimal.new(product.bundle_size))
      |> Decimal.mult(product.price)
      |> Decimal.round(2)
    end
  end
end

defmodule Domain.FoundProduct do
  @moduledoc """
    Module for the FoundProduct struct to model products.

    # Example
        iex> %FoundProduct{name: "Banana", price: Decimal.new("1.99"), found: 4}
        %FoundProduct{name: "Banana", price: Decimal.new("1.99"), found: 4}
  """

  defstruct [:name, :price, :found]

  defimpl Domain.Product do
    def print_product(product) do
      IO.puts "Product Name: #{product.name}, Price: #{product.found} pounds for #{Domain.ProductHelper.to_dollar(product.price)} per unit"
    end

    def price(product, found) do
      product.price
      |> Decimal.mult(Decimal.new(found))
      |> (&Decimal.div(&1, Decimal.new(product.found))).()
      |> Decimal.round(2)
    end
  end
end