class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :seller
  belongs_to :product
  mount_uploader :invoice, InvoiceUploader
  enum order_status: { "placed": 0, "delivered":1, "returned": 2}
end
