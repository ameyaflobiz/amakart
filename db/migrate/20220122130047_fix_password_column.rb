class FixPasswordColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password, :password_digest
    rename_column :stores, :password, :password_digest
  end
end
