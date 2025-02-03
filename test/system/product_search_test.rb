require "application_system_test_case"

class ProductSearchTest < ApplicationSystemTestCase
  setup do
    @product1 = Product.create(name: "Laptop", price: 1000, quantity: 5)
    @product2 = Product.create(name: "Mouse", price: 50, quantity: 10)
    @product3 = Product.create(name: "Keyboard", price: 80, quantity: 8)
  end

  test "user searches for a product using autosubmit" do
    visit products_path

    assert_text "Laptop"
    assert_text "Mouse"

    fill_in "Search by product name", with: "Mouse"

    assert_text "Mouse", wait: 2
    refute_text "Laptop"
  end
end
