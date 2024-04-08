defmodule ProductTest do
  use ExUnit.Case
  doctest Domain.Product

  alias Domain.{
    BundleProduct,
    FoundProduct,
    SingleProduct,
    Product}

  setup do
    single_product = %SingleProduct{name: "Peanut Can", price: Decimal.new("0.65")}
    bundle_product = %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3}
    found_product = %FoundProduct{name: "Banana", price: Decimal.new("1.99"), found: 4}
    {:ok, single: single_product, bundle: bundle_product, found: found_product}
  end

  test "single product price", %{single: single_product} do
    assert Product.price(single_product, 1) == Decimal.new("0.65"),
           "Expected price for single product of 1 is 0.65"
  end

  test "bundle product price", %{bundle: bundle_product} do
    assert Product.price(bundle_product, 3) == Decimal.new("1.00"),
           "Expected price for bundle product of 3 is 1.00"
    assert Product.price(bundle_product, 6) == Decimal.new("2.00"),
           "Expected price for bundle product of 6 is 2.00"
  end

  test "under bundle size product price", %{bundle: bundle_product} do
    assert Product.price(bundle_product, 1) == Decimal.new("0.33"),
           "Expected price for bundle product of 1 is 0.33"
    assert Product.price(bundle_product, 2) == Decimal.new("0.67"),
           "Expected price for bundle product of 2 is 0.67"
  end

  test "found product price", %{found: found_product} do
    assert Product.price(found_product, 4) == Decimal.new("1.99"),
           "Expected price for found product of 4 is 1.99"
    assert Product.price(found_product, 8) == Decimal.new("3.98"),
           "Expected price for found product of 4 is 1.99"
    assert Product.price(found_product, 1) == Decimal.new("0.50"),
           "Expected price for found product of 1 is 1.99"
    assert Product.price(found_product, 2) == Decimal.new("1.00"),
           "Expected price for found product of 2 is 1.00"
  end
end
