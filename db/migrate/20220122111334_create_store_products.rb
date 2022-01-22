class CreateStoreProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :store_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.decimal :price, default: 0
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
