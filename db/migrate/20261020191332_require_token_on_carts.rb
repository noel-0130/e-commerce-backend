class RequireTokenOnCarts < ActiveRecord::Migration[8.1]
  def change
    change_column_null :carts, :token, false
  end
end
