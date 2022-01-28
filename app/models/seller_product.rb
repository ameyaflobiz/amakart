class SellerProduct < ApplicationRecord
  belongs_to :product
  belongs_to :seller

  #Same products cannot be added again
  validates_uniqueness_of :product_id, scope: :seller_id

  validates: :price,:stock, numericality: {:greater_than_or_equal_to: 0}
  
end
