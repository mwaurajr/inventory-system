# Clear existing data
puts "Clearing existing products..."
Product.destroy_all

# Create new products
puts "Creating products..."

products = [
  {
    name: "Wireless Earbuds",
    description: "High-quality wireless earbuds with noise cancellation",
    price: 129.99,
    quantity: 15
  },
  {
    name: "Smart Watch",
    description: "Fitness tracking smartwatch with heart rate monitor",
    price: 199.99,
    quantity: 8  # Will trigger low stock notification
  },
  {
    name: "Laptop Backpack",
    description: "Water-resistant backpack with USB charging port",
    price: 49.99,
    quantity: 25
  },
  {
    name: "Coffee Maker",
    description: "Programmable coffee maker with thermal carafe",
    price: 79.99,
    quantity: 0  # Will trigger out of stock notification
  },
  {
    name: "Gaming Mouse",
    description: "RGB gaming mouse with programmable buttons",
    price: 59.99,
    quantity: 5  # Will trigger low stock notification
  },
  {
    name: "Portable Charger",
    description: "20000mAh power bank with fast charging",
    price: 45.99,
    quantity: 30
  },
  {
    name: "Mechanical Keyboard",
    description: "RGB mechanical keyboard with blue switches",
    price: 89.99,
    quantity: 12
  },
  {
    name: "Bluetooth Speaker",
    description: "Waterproof portable speaker with 20-hour battery life",
    price: 69.99,
    quantity: 3  # Will trigger low stock notification
  },
  {
    name: "4K Webcam",
    description: "Ultra HD webcam with auto-focus and noise-canceling microphone",
    price: 149.99,
    quantity: 18
  },
  {
    name: "Standing Desk",
    description: "Electric height-adjustable desk with memory settings",
    price: 299.99,
    quantity: 7  # Will trigger low stock notification
  }
]

products.each do |product_data|
  product = Product.create!(product_data)
  puts "Created #{product.name} with ID: #{product.id}"
end

puts "Created #{Product.count} products"
