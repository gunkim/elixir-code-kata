defmodule ProductPriceType do
  @single :single
  @bundle :bundle
  @found :found

  @doc """
    Returns the single price type.
  """
  def single, do: @single
  @doc """
    Returns the bundle price type.
  """
  def bundle, do: @bundle
  @doc """
    Returns the found price type.
  """
  def found, do: @found
end
