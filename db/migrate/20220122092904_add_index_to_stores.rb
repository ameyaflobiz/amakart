class AddIndexToStores < ActiveRecord::Migration[6.0]
  def change

    add_index :stores, :email, unique: true
  end
end
