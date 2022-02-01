class OrderService

	def add_order_to_redis(params)
		# Shouldv'e add check for quantity 
		product_from_seller = SellerProduct.find_by(seller_id: params[:seller_id], product_id: params[:product_id])
		
		stock_check(product_from_seller.stock,params[:quantity])

		REDIS.rpush("order_for_user_#{params[:user_id]}",
					"#{ params[:product_id] },#{ params[:seller_id] },#{ params[:quantity] }"
				  )
	end
	def generate_order(user_id, user_type)


		if user_type == "seller"

			raise CustomException.new(400, "Sellers can't buy products")

		end
		
		products = REDIS.lrange("order_for_user_#{user_id}", 0, -1)

		address = User.find(user_id).address.shipping_address

		# TRANSACTIONSS (use transactions when in case of write ops )
		

 		ActiveRecord::Base.transaction do
 			@order = Order.create!(user_id: user_id, address: address)
 			order_items = []
 			seller_products_updates=[]
	 		products.each do |product|
				product_id,seller_id,quantity = product.split(',')
				product_id = product_id.to_i
				seller_id = seller_id.to_i
				quantity = quantity.to_i

				seller_product = SellerProduct.includes(:seller).find_by(product_id: product_id,seller_id: seller_id)
				stock = seller_product.stock

				stock_check(stock,quantity)

				seller_shipping_address = seller_product.seller.address.shipping_address
				seller_billing_address = seller_product.seller.address.billing_address

				price = seller_product.price
				
				order_items.push({
								 	order_id: @order.id,
								 	product_id: product_id,
								 	seller_id: seller_id,
								 	quantity: quantity,
								 	shipping_address_seller: seller_shipping_address,
								 	billing_address_seller: seller_billing_address,
								 	price: price,
									created_at: DateTime.now,
									updated_at: DateTime.now

								})

				seller_products_updates.push({
								 	
								 	product_id: product_id,
								 	seller_id: seller_id,
								 	price: price,
								 	stock: stock-quantity,
								 	created_at: seller_product.created_at,
									updated_at: DateTime.now

								})

		
			end
			OrderProduct.upsert_all(order_items)
			SellerProduct.upsert_all(seller_products_updates)
 		end

		# Generate only after Transaction Commit
		GeneratePdfWorker.perform_async(@order.id)

		REDIS.del("order_for_user_#{user_id}")
		
		
	end

	private
	def seller_product_params
		params.require(:seller_id, :product_id)
	end

	def stock_check(stock,quantity)
		if(stock < quantity.to_i)
			raise CustomException.new(400,"Not enough products in stock")
		end
	end
end