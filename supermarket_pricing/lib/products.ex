defmodule Products do
  @moduledoc """
    Module for the Products struct to model products.
  """

  @doc """
    Searches for a product by name.
  """
  @spec search([Product.t], String.t) :: Product.t
  def search(products, name) do
    downcased_name = downcase_string(name)
    Enum.find(products, fn product -> product_name_matches?(product, downcased_name) end)
  end

  defp product_name_matches?(product, name), do: downcase_string(product.name) == name
  defp downcase_string(string), do: String.downcase(string)
end