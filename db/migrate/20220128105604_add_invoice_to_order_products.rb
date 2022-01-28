class AddInvoiceToOrderProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :order_products, :invoice, :string
  end
end
