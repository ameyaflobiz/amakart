class Product < ApplicationRecord
	has_many :seller_products
	has_many :sellers, through: :seller_products
	has_many :order_products
	has_many :orders, through: :order_products

	validates :name, presence: true
end
