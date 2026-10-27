# db/seeds.rb

products = [
  {
    name: "Acer Aspire 5 Laptop",
    description: "Laptop for productivity and everyday computing.",
    price: 32999.00,
    stock: 10,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/IMG_20261027_130439.jpg"
  },
  {
    name: "ASUS VivoBook 15",
    description: "Everyday laptop for work and study.",
    price: 29999.00,
    stock: 15,
    image_url: "https://elnstore.com/cdn/shop/files/Asus_X1504VA-NJ1622WSM.png?v=1756011835&width=1946"
  },
  {
    name: "Lenovo IdeaPad Slim 3",
    description: "Slim laptop for everyday computing.",
    price: 27999.00,
    stock: 12,
    image_url: "https://cdn.mafrservices.com/pim-content/EGY/media/product/660066/1756281605/660066_main.jpg"
  },
  {
    name: "HP Pavilion 15 Laptop",
    description: "Laptop for productivity and entertainment.",
    price: 35999.00,
    stock: 8,
    image_url: "https://amso.pl/hpeciai/22e00a6b92623df98b3721551c836c43/pol_pl_HP-Pavilion-15-EG2XXX-i5-1235U-16GB-512GB-SSD-1920x1080-Klasa-A-Windows-11-Home-303286_1.jpg"
  },
  {
    name: "Dell Inspiron 15 Laptop",
    description: "Versatile laptop for work and home.",
    price: 38999.00,
    stock: 7,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/1000000014439.1.jpg"
  },
  {
    name: "AMD Ryzen 5 5600X Processor",
    description: "Desktop processor for gaming and productivity.",
    price: 6499.00,
    stock: 20,
    image_url: "https://www.itworldph.com/web/image/product.template/8030/image_1920?unique=5d5d864"
  },
  {
    name: "AMD Ryzen 7 5800X Processor",
    description: "High-performance desktop processor.",
    price: 9499.00,
    stock: 12,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/2505503-ryzen-7-5800x.webp"
  },
  {
    name: "NVIDIA GeForce RTX 3060 Graphics Card",
    description: "Graphics card for gaming and creative work.",
    price: 19999.00,
    stock: 5,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/image_1c233bb6-0d59-49b6-8fef-1cc1ba3b566f_1024x1024.png"
  },
  {
    name: "AMD Radeon RX 6600 Graphics Card",
    description: "Graphics card for gaming and multimedia.",
    price: 12999.00,
    stock: 6,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/Radeon_RX_6600_Challenger_D_8GB_L1.png"
  },
  {
    name: "Corsair Vengeance 16GB DDR4 RAM",
    description: "Memory module for desktop computers.",
    price: 1899.00,
    stock: 30,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/VENG_LPX_BLK_01.webp"
  },
  {
    name: "WD Blue 1TB HDD",
    description: "Hard drive for desktop storage.",
    price: 2499.00,
    stock: 18,
    image_url: "https://trusttechspace.blr1.cdn.digitaloceanspaces.com/media/mN8IUqBiUIWGif9GmoiljWiVvkxTPXKh1mWL43T0.jpg"
  },
  {
    name: "Samsung 970 EVO Plus 500GB SSD",
    description: "NVMe solid-state drive for fast storage.",
    price: 4299.00,
    stock: 14,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/Samsung_970_Evo_Plus_M.2_NVME-a_2048x2048.jpg"
  },
  {
    name: "Kingston NV2 1TB SSD",
    description: "NVMe drive for faster boot times and storage.",
    price: 2199.00,
    stock: 22,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/0740617329919.jpg"
  },
  {
    name: "Seagate BarraCuda 2TB HDD",
    description: "Hard drive for storage and backups.",
    price: 3499.00,
    stock: 10,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/bdfbdfdbf.jpg"
  },
  {
    name: "ASUS PRIME B550M-A Motherboard",
    description: "Motherboard for compatible AMD desktop builds.",
    price: 5499.00,
    stock: 9,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/P_setting_xxx_0_90_end_500.png"
  },
  {
    name: "Corsair CV550 550W Power Supply",
    description: "Power supply for desktop computer builds.",
    price: 3499.00,
    stock: 11,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/CP-9020210-NA-Gallery-CV550-PSU-01.png"
  },
  {
    name: "Logitech G102 Gaming Mouse",
    description: "Wired gaming mouse with adjustable sensitivity.",
    price: 1099.00,
    stock: 25,
    image_url: "https://www.itworldph.com/web/image/product.template/10958/image_1920?unique=22a85d2"
  },
  {
    name: "Logitech K120 Keyboard",
    description: "Wired keyboard for everyday typing.",
    price: 1899.00,
    stock: 16,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/dsagfdvDSA.jpg"
  },
  {
    name: "AOC 24B2XH 24-inch Monitor",
    description: "24-inch monitor for work and gaming.",
    price: 5999.00,
    stock: 8,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/e3e42cd969c6c192afca158b5f86d0b5b36d0727-3840x3840.png"
  },
  {
    name: "DeepCool N80 RGB Cooling Pad",
    description: "Cooling pad to help improve laptop airflow.",
    price: 799.00,
    stock: 20,
    image_url: "https://res.cloudinary.com/lfgvxtv8/image/upload/ar_9:16,c_auto/f_auto/q_auto/IMG_20261027_133006.jpg"
  }
]

# Reset products and their associated cart items.
# Users are preserved.
ActiveRecord::Base.transaction do
  products.each do |attributes|
    product = Product.find_or_initialize_by(name: attributes[:name])
    product.assign_attributes(attributes)
    product.save!
  end
end

puts "Products updated: #{Product.count}"
puts "Products without images: #{Product.where(image_url: [nil, ""]).count}"