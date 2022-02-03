class Seller < ApplicationRecord
    acts_as_paranoid
    has_secure_password
    has_one_time_password
	has_one :address, as: :addressable, dependent: :destroy
    has_one :image, as: :imageable, dependent: :destroy
    has_many :seller_products, dependent: :destroy
    has_many :products, through: :seller_products 

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP ,message: "Please enter a valid email" } 
    validates :password, length: { in: 6..20 }
    validates_associated :address
  
end
