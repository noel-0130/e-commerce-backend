namespace :db do
  desc "Reset all application data and reseed products"
  task reset_products: :environment do
    ActiveRecord::Base.transaction do
      puts "Deleting order items..."
      OrderItem.delete_all

      puts "Deleting orders..."
      Order.delete_all

      puts "Deleting cart items..."
      CartItem.delete_all

      puts "Deleting carts..."
      Cart.delete_all

      puts "Deleting users..."
      User.delete_all

      puts "Deleting products without images..."
      Product.where(image_url: [nil, ""]).destroy_all

      puts "Updating or creating products..."
      Rake::Task["db:seed"].reenable
      Rake::Task["db:seed"].invoke
    end

    puts "Reset completed!"
    puts "Users: #{User.count}"
    puts "Orders: #{Order.count}"
    puts "Carts: #{Cart.count}"
    puts "Products: #{Product.count}"
    puts "Products without images: #{Product.where(image_url: [nil, ""]).count}"
  end
end