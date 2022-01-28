class Seller < ApplicationRecord
    has_secure_password
    has_one_time_password
	has_one :address, as: :addressable
    has_many :seller_products 
    has_many :products, through: :seller_products

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP ,message: "Please enter a valid email" } 
    validates :password, length: { in: 6..20 }
    validates_associated :address
  
end
