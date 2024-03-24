defmodule ProductPriceType do
  @enumerable [:quantity, :weight]

  defmacro __using__(_) do
    quote do
      @type t :: unquote(@enumerable)
    end
  end
end
