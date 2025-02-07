require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product1 = Product.create(name: "Laptop", price: 1000, quantity: 5)
    @product2 = Product.create(name: "Mouse", price: 50, quantity: 10)
    @product3 = Product.create(name: "Keyboard", price: 80, quantity: 8)
  end

  test "should not save product without name" do
    product = Product.new(price: 9.99, quantity: 5)
    assert_not product.save, "Saved the product without a name"
  end

  test "stock status class for out of stock" do
    product = Product.new(quantity: 0)
    assert_equal "text-red-600 font-bold", product.stock_status_class
  end

  test "stock status class for low stock" do
    product = Product.new(quantity: 5)
    assert_equal "text-yellow-600 font-bold", product.stock_status_class
  end

  test "stock status class for in stock" do
    product = Product.new(quantity: 20)
    assert_equal "text-green-600", product.stock_status_class
  end
end
