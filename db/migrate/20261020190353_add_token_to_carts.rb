class AddTokenToCarts < ActiveRecord::Migration[8.1]
  def change
    add_column :carts, :token, :string
    add_index :carts, :token, unique: true
  end
end