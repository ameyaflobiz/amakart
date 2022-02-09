class AddDeletedAtToModels < ActiveRecord::Migration[6.0]
  def change
        add_column :seller_products, :deleted_at, :datetime
        add_column :images, :deleted_at, :datetime
        add_column :addresses, :deleted_at, :datetime

        remove_index :sellers, :deleted_at
        remove_index :users, :deleted_at
        remove_index :products, :deleted_at
  end
end
