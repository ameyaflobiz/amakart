class Product < ApplicationRecord
	has_many :seller_products
	has_many :sellers, through: :seller_products
end
