class SellerProduct < ApplicationRecord
  belongs_to :product
  belongs_to :seller

  #Same products cannot be added again
  validates_uniqueness_of :product_id, scope: :seller_id
end
