class Image < ApplicationRecord
	belongs_to :imageable, polymorphic: true
	mount_uploader :file, ImageUploader
	validates :file, presence: true

end
