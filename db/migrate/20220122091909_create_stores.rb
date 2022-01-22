class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :otp_secret_key

      t.timestamps
    end
  end
end
