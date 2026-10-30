class AddEmailVerifiedAtToUsers < ActiveRecord::Migration[8.1]
  def up
    add_column :users, :email_verified_at, :datetime
    execute "UPDATE users SET email_verified_at = NOW() WHERE google_uid IS NOT NULL"
  end

  def down
    remove_column :users, :email_verified_at
  end
end