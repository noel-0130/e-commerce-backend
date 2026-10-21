# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
products = [
  {
    name: "Acer Aspire 5 Laptop",
    description: "Laptop for productivity and everyday computing.",
    price: 32999.00,
    stock: 10
  },
  {
    name: "ASUS VivoBook 15",
    description: "Everyday laptop for work and study.",
    price: 29999.00,
    stock: 15
  },
  {
    name: "Lenovo IdeaPad Slim 3",
    description: "Slim laptop for everyday computing.",
    price: 27999.00,
    stock: 12
  },
  {
    name: "HP Pavilion Laptop",
    description: "Laptop for productivity and entertainment.",
    price: 35999.00,
    stock: 8
  },
  {
    name: "Dell Inspiron Laptop",
    description: "Versatile laptop for work and home.",
    price: 38999.00,
    stock: 7
  },
  {
    name: "AMD Ryzen 5 5600",
    description: "Desktop processor for gaming and productivity.",
    price: 6499.00,
    stock: 20
  },
  {
    name: "Intel Core i5 Processor",
    description: "Desktop processor for everyday computing.",
    price: 9499.00,
    stock: 12
  },
  {
    name: "NVIDIA GeForce RTX 4060",
    description: "Graphics card for gaming and creative work.",
    price: 19999.00,
    stock: 5
  },
  {
    name: "AMD Radeon Graphics Card",
    description: "Graphics card for gaming and multimedia.",
    price: 12999.00,
    stock: 6
  },
  {
    name: "Kingston 16GB DDR4 RAM",
    description: "Memory module for desktop computers.",
    price: 1899.00,
    stock: 30
  },
  {
    name: "Corsair 32GB DDR5 RAM",
    description: "High-capacity memory for modern computers.",
    price: 4499.00,
    stock: 18
  },
  {
    name: "Samsung 970 EVO Plus 1TB SSD",
    description: "NVMe solid-state drive for fast storage.",
    price: 4299.00,
    stock: 14
  },
  {
    name: "Kingston 500GB NVMe SSD",
    description: "Compact NVMe drive for faster boot times.",
    price: 2199.00,
    stock: 22
  },
  {
    name: "Seagate 2TB External HDD",
    description: "External hard drive for backup and storage.",
    price: 3499.00,
    stock: 10
  },
  {
    name: "ASUS Prime B550M Motherboard",
    description: "Motherboard for compatible AMD desktop builds.",
    price: 5499.00,
    stock: 9
  },
  {
    name: "Corsair 650W Power Supply",
    description: "Power supply for desktop computer builds.",
    price: 3499.00,
    stock: 11
  },
  {
    name: "Logitech G102 Gaming Mouse",
    description: "Wired gaming mouse with adjustable sensitivity.",
    price: 1099.00,
    stock: 25
  },
  {
    name: "Mechanical Gaming Keyboard",
    description: "Mechanical keyboard for gaming and typing.",
    price: 1899.00,
    stock: 16
  },
  {
    name: "AOC 24-inch Monitor",
    description: "24-inch monitor for work and gaming.",
    price: 5999.00,
    stock: 8
  },
  {
    name: "Laptop Cooling Pad",
    description: "Cooling pad to help improve laptop airflow.",
    price: 799.00,
    stock: 20
  }
]

products.each do |attributes|
  Product.find_or_create_by!(name: attributes[:name]) do |product|
    product.assign_attributes(attributes)
  end
end

puts "Products in database: #{Product.count}"