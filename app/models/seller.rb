class Seller < ApplicationRecord
	has_one :address, as: :addressable
end
