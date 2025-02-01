require "application_system_test_case"

class ProductNotificationsTest < ApplicationSystemTestCase
  setup do
    # Create a product with an initial quantity of 11.
    @product = Product.create!(
      name: "Test Product",
      description: "This is a test product.",
      price: 19.99,
      quantity: 11
    )
  end

  test "low stock notification appears when product quantity is reduced to 10" do
    # Visit the product show page
    visit product_path(@product)

    # Assert that no notification is visible yet
    assert_no_text "Low Stock Warning!"

    # Simulate deletion of one unit by updating the product's quantity to 10
    @product.update(quantity: 10)

    # Reload the page (or trigger Turbo stream updates in a real app)
    visit current_path

    # Check for the presence of the low stock notification
    assert_text "Low Stock Warning!"
    assert_text "Only 10 left in stock."
  end
end
