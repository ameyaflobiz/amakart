class Image < ApplicationRecord
	acts_as_paranoid
	belongs_to :imageable, polymorphic: true
	mount_uploader :file, ImageUploader
	validates :file, presence: true

end
