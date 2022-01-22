class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :store, null: false, foreign_key: true
      t.integer :order_status, default: 0
      t.decimal :price, default: 0
      t.json :shipping_address_store
      t.json :billing_address_store

      t.timestamps
    end
  end
end
