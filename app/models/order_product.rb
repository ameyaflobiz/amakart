class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :seller
  belongs_to :product
  mount_uploader :invoice, InvoiceUploader
  enum order_status: { "placed": 0, "delivered":1, "returned": 2}

  validates :product_id,:user_id,:seller_id,:shipping_address_seller,:billing_address_seller,:price, presence: true
end
