defmodule Domain.ProductsTest do
  use ExUnit.Case
  doctest Domain.Products

  alias Domain.{
    BundleProduct,
    FoundProduct,
    SingleProduct,
    Products}

  setup do
    products = [
      %SingleProduct{name: "Peanut Can", price: Decimal.new("0.65")},
      %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3},
      %FoundProduct{name: "Banana", price: Decimal.new("1.99"), found: 4},
      %SingleProduct{name: "Shampoo", price: Decimal.new("1.5")}
    ]
    expectedProduct = %BundleProduct{name: "Apple", price: Decimal.new("1"), bundle_size: 3}

    {:ok, %{products: products, expectedProduct: expectedProduct}}
  end

  test "Returns a product when the name is in lowercase", %{products: products, expectedProduct: expectedProduct} do
    assert Products.search(products, "apple") == expectedProduct
  end

  test "Returns a product when the name is in uppercase", %{products: products, expectedProduct: expectedProduct} do
    assert Products.search(products, "APPLE") == expectedProduct
  end

  test "Returns a product when the name is in mixed case", %{products: products, expectedProduct: expectedProduct} do
    assert Products.search(products, "AppLe") == expectedProduct
  end
end