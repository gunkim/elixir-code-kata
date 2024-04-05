defmodule Product do
  @moduledoc """
    Module for the Product struct to model products.
  """
  @type t :: %__MODULE__{
               name: String.t,
               price: Decimal.t,
               price_type: ProductPriceType.t,
               bundle_size: integer,
               found: integer
             }
  defstruct name: nil,
            price: nil,
            price_type: nil,
            bundle_size: nil,
            found: nil

  @doc """
    Creates a single product.
  """
  @spec create_single(String.t, Decimal.t) :: t
  def create_single(name, price) do
    create_base(name, price, ProductPriceType.single)
  end

  @doc """
    Creates a bundle product.
  """
  @spec create_bundle(String.t, Decimal.t, integer) :: t
  def create_bundle(name, price, bundle_size) do
    create_base(name, price, ProductPriceType.bundle)
    |> Map.put(:bundle_size, bundle_size)
  end

  @doc """
    Creates a found product.
  """
  @spec create_found(String.t, Decimal.t, integer) :: t
  def create_found(name, price, found) do
    create_base(name, price, ProductPriceType.found)
    |> Map.put(:found, found)
  end

  @doc """
    Prints a product to the console.
  """
  @spec print_product(t) :: :ok
  def print_product(%{price_type: :single} = product) do
    IO.puts "Product Name: #{product.name}, Per unit: #{to_dollar(product.price)}"
  end
  @spec print_product(t) :: :ok
  def print_product(%{price_type: :bundle} = product) do
    IO.puts "Product Name: #{product.name}, Per bundle of #{product.bundle_size} units: #{to_dollar(product.price)}"
  end
  @spec print_product(t) :: :ok
  def print_product(%{price_type: :found} = product) do
    IO.puts "Product Name: #{product.name}, Per pound: #{to_dollar(product.price)}"
  end

  @doc """
    Calculates the price of a product.
  """
  @spec price(t, Decimal.t) :: Decimal.t
  def price(%Product{price_type: :single, price: price} = product, quantity), do: Decimal.mult(quantity, price)
  def price(%Product{price_type: :bundle, price: price, bundle_size: bundle_size} = product, quantity), do:
    Decimal.div(quantity, Decimal.new(bundle_size))
    |> Decimal.mult(price)
    |> Decimal.round(2)
  def price(%Product{price_type: :found, price: price} = product, weight), do: Decimal.mult(weight, price)

  # Converts a price to a dollar string.
  defp to_dollar(price) do
    "$#{Decimal.to_string(price)}"
  end

  # Creates a base product.
  @spec create_base(String.t, Decimal.t, ProductPriceType.t) :: t
  defp create_base(name, price, price_type) do
    %Product{
      name: name,
      price: price,
      price_type: price_type
    }
  end
end
