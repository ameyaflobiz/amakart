class Product < ApplicationRecord
	acts_as_paranoid
	has_many :seller_products, dependent: :destroy
	has_many :sellers, through: :seller_products
	has_many :order_products, dependent: :destroy
	has_many :orders, through: :order_products
	has_many :images, as: :imageable, dependent: :destroy

	validates :name, presence: true
	scope :filter_by_department, ->(brand) { where('details @> ?', { department: department }.to_json) } 
	scope :filter_by_brand, ->(brand) { where('details @> ?', { brand: brand }.to_json) }
	scope :filter_by_color, ->(color) { where('details @> ?', { color: color }.to_json) }
	scope :contains_string, ->(search_query) { where("name like ?", "%#{search_query}%" ) }

end
