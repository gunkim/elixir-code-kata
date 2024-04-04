defmodule Product do
  @moduledoc """
    Module for the Product struct to model products.
  """
  @type t :: %__MODULE__{
               name: String.t,
               price: Decimal.t,
               price_type: ProductPriceType.t,
               count: integer,
               found: integer
             }
  defstruct name: nil,
            price: nil,
            price_type: nil,
            count: nil,
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
  def create_bundle(name, price, count) do
    create_base(name, price, ProductPriceType.bundle)
    |> Map.put(:count, count)
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
  def print_product(product) do
    IO.write("Product Name: #{product.name}, ")

    case product.price_type do
      :single ->
        IO.puts "Per unit: $#{Decimal.to_string(product.price)}"
      :bundle ->
        IO.puts "Per bundle of #{product.count} units: $#{Decimal.to_string(product.price)}"
      :found ->
        IO.puts "Per pound: $#{Decimal.to_string(product.price)}"
    end
  end

  @doc """
    Calculates the price of a product.
  """
  @spec price(t, Decimal.t) :: Decimal.t
  def price(product, count) do
    case product.price_type do
      :single -> Decimal.mult(count, product.price)
      :bundle ->
        Decimal.div(count, product.count)
        |> Decimal.mult(product.price)
        |> Decimal.round(2)
      :found -> Decimal.mult(count, product.price)
    end
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