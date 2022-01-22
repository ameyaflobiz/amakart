class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :otp_secret_key
      t.integer :type
      t.string :phone_num

      t.timestamps
    end
  end
end
