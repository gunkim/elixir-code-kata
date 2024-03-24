defmodule ElixirCodeKata.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      apps: [:supermarket_pricing]
    ]
  end

  defp deps do
    []
  end
end
