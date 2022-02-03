class ChangeJsonToJsonb < ActiveRecord::Migration[6.0]
  
  def change

    change_column :products, :details, :jsonb
    change_column :addresses, :shipping_address, :jsonb
    change_column :addresses, :billing_address, :jsonb 
    change_column :orders, :address, :jsonb
    change_column :order_products, :shipping_address_seller, :jsonb
    change_column :order_products, :billing_address_seller, :jsonb

  end

end
