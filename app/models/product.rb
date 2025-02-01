class Product < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  # Helper to determine CSS class based on stock level
  def stock_status_class
    if quantity.zero?
      "text-red-600 font-bold"
    elsif quantity <= 10
      "text-yellow-600 font-bold"
    else
      "text-green-600"
    end
  end

  # Helper to display stock text
  def stock_display
    quantity.zero? ? "Out of Stock" : quantity.to_s
  end
end
