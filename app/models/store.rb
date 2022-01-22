class Store < ApplicationRecord
	has_one :address, as: :addressable
end
