class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.string :customer_email
      t.text :shipping_address
      t.decimal :total_amount, precision: 10, scale: 2, null:false
      t.string :status, default: "pending", null:false

      t.timestamps
    end
  end
end
bin