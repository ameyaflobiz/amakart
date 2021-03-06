class User < ApplicationRecord
    acts_as_paranoid
    has_secure_password
    has_one_time_password
	has_one :address, as: :addressable, dependent: :destroy
    has_one :image, as: :imageable, dependent: :destroy
    
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP ,message: "Please enter a valid email" } 
    validates :password, length: { in: 6..20 }
    validates :phone_num, numericality: { only_integer: true }, length:{ is: 10 }
    validates_associated :address
    
    enum user_type: USER_ROLES

end
