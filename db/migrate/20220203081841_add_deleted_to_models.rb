class AddDeletedToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
    add_column :products, :deleted_at, :datetime

    add_index :sellers, :deleted_at
    add_index :users, :deleted_at
    add_index :products, :deleted_at
  end
end
