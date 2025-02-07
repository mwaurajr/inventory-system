class Product < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  broadcasts_to ->(_product) { "products" }, inserts_by: :prepend

  scope :name_like, ->(term) { where("LOWER(name) LIKE ?", "%#{term.downcase}%") if term.present? }
  scope :min_price, ->(price) { where("price >= ?", price) if price.present? }
  scope :max_price, ->(price) { where("price <= ?", price) if price.present? }

  # Helper to filter products based on price, name and, quantity
  def self.filter(params)
    products = all
      .name_like(params[:name])
      .min_price(params[:min_price])
      .max_price(params[:max_price])
    if params[:column].present? && params[:direction].present?
      allowed_columns = %w[name price quantity]
      allowed_directions = %w[asc desc]
      products = if allowed_columns.include?(params[:column]) && allowed_directions.include?(params[:direction])
        products.order("#{params[:column]} #{params[:direction]}")
      else
        products.order(:name)
      end
    else
      products = products.order(:name)
    end
    products
  end

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
