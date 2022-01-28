class Address < ApplicationRecord
	belongs_to :addressable, polymorphic: true

	validates :shipping_address,:billing_address, presence: true
	
end
