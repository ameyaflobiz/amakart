class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.json :shipping_address
      t.json :billing_address
      t.string :addressable_type
      t.integer :addressable_id

      t.timestamps
    end
    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
