require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    Product.destroy_all

    @product1 = Product.create!(name: 'Laptop', price: 1000, quantity: 5)
    @product2 = Product.create!(name: 'Mouse', price: 50, quantity: 10)
    @product3 = Product.create!(name: 'Keyboard', price: 80, quantity: 8)
  end

  test 'min_price scope filters products by minimum price' do
    assert_equal [@product1], Product.min_price(500)
  end

  test 'max_price scope filters products by maximum price' do
    assert_equal [@product2, @product3].sort_by(&:price), Product.max_price(100).order(:price)
  end

  test 'filter method applies name, price range, and sorting' do
    filtered = Product.filter(name: 'o', min_price: 50, max_price: 100, column: 'price', direction: 'asc')
    assert_equal [@product2, @product3].sort_by(&:price), filtered.to_a
  end
end
