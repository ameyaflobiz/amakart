class OrderService

	def add_order(params)

		@seller_product = SellerProduct.find_by(seller_id: params[:seller_id], product_id: params[:product_id])
		# Add order to orders table
		if params[:user_type] == "seller"

			raise CustomException.new("raised in order controller", "Sellers can't buy products")

		elsif @seller_product.stock == 0
			raise CustomException.new("raised in order controller", "Seller doesn't have the product in stock")

		end
		
		user_id = params[:user_id]
		address = User.find(user_id).address.shipping_address
		@order = Order.create!(user_id: user_id, address: address)
		# Add order to join table also
		@seller = Seller.find(params[:seller_id])
		
		seller_shipping_address = @seller.address.shipping_address
		seller_billing_address = @seller.address.billing_address

		price = @seller_product.price
		stock = @seller_product.stock

		@seller_product.update!(stock: stock-1)
		@invoice_details = OrderProduct.create!(order_id: @order.id, product_id: params[:product_id], seller_id: params[:seller_id], shipping_address_seller: seller_shipping_address, billing_address_seller: seller_billing_address , price: price)
		
	end
end