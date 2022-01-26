class User < ApplicationRecord
    has_secure_password
    has_one_time_password
	has_one :address, as: :addressable
    enum user_type: USER_ROLES
    accepts_nested_attributes_for :address
end
