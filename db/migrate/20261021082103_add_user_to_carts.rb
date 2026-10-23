class AddUserToCarts < ActiveRecord::Migration[8.1]
  def change
    add_reference :carts, :user, foreign_key: true
  end
end