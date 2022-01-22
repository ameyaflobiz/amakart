class User < ApplicationRecord
    has_secure_password
    has_one_time_password
	has_one :address, as: :addressable
end
