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
