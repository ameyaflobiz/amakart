class OrderService

	def add_order_to_redis(params)

		REDIS.rpush("order_for_user_#{params[:user_id]}",
					"#{ params[:product_id] },#{ params[:seller_id] }"
				  )
	end
	def generate_order(user_id, user_type)


		if user_type == "seller"

			raise CustomException.new("raised in order controller", "Sellers can't buy products")

		end
		
		products = REDIS.lrange("order_for_user_#{user_id}", 0, -1)

		address = User.find(user_id).address.shipping_address

		@order = Order.create!(user_id: user_id, address: address)

		products.each do |product|
			product_id,seller_id = product.split(',')
			product_id = product_id.to_i
			seller_id = seller_id.to_i

			seller_product = SellerProduct.includes(:seller).find_by(product_id: product_id,seller_id: seller_id)
			seller_shipping_address = seller_product.seller.address.shipping_address
			seller_billing_address = seller_product.seller.address.billing_address

			price = seller_product.price
			stock = seller_product.stock

			invoice_details = OrderProduct.create!(order_id: @order.id, product_id: product_id, seller_id: seller_id, shipping_address_seller: seller_shipping_address, billing_address_seller: seller_billing_address , price: price)
			puts invoice_details
			seller_product.update!(stock: stock-1)
			GeneratePdfWorker.perform_async(invoice_details.id,invoice_details.seller_id,invoice_details.order_id,invoice_details.product_id)
		end

		REDIS.del("order_for_user_#{user_id}")
		
		
	end

	private
	def seller_product_params
		params.require(:seller_id, :product_id)
	end
end