defmodule Product do
  @moduledoc """
    Module for the Product struct to model products.
  """
  @type t :: %__MODULE__{
          name: String.t,
          price: Decimal.t,
          price_type: ProductPriceType.t
        }
  defstruct name: nil,
            price: nil,
            price_type: nil
end
