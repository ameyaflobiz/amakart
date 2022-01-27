class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :seller
  belongs_to :product
end
