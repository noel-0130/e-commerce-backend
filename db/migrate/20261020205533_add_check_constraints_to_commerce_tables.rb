class AddCheckConstraintsToCommerceTables < ActiveRecord::Migration[8.1]
  def change
    add_check_constraint :products, "price >= 0",
                         name: "products_price_non_negative"

    add_check_constraint :products, "stock >= 0",
                         name: "products_stock_non_negative"

    add_check_constraint :orders, "total_amount >= 0",
                         name: "orders_total_amount_non_negative"

    add_check_constraint :order_items, "price >= 0",
                         name: "order_items_price_non_negative"

    add_check_constraint :order_items, "quantity > 0",
                         name: "order_items_quantity_positive"

    add_check_constraint :cart_items, "quantity > 0",
                         name: "cart_items_quantity_positive"
  end
end