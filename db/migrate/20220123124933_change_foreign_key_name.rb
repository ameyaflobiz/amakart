class ChangeForeignKeyName < ActiveRecord::Migration[6.0]
  def change
    rename_column :order_products, :store_id, :seller_id
    rename_column :store_products, :store_id, :seller_id
    rename_table  :store_products, :seller_products
    rename_column :order_products, :shipping_address_store, :shipping_address_seller
    rename_column :order_products, :billing_address_store, :billing_address_seller

  end
end
