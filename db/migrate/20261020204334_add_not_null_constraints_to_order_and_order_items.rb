class AddNotNullConstraintsToOrderAndOrderItems < ActiveRecord::Migration[8.1]
  def change
    change_column_null :orders, :customer_name, false
    change_column_null :orders, :customer_email, false
    change_column_null :orders, :shipping_address, false

    change_column_null :order_items, :product_name, false
  end
end