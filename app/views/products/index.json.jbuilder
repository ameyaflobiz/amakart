json.search_query do 
	json.array! @products do |product|
		json.name product.name

		json.seller_one do
			if product.seller_products.size > 0
				
				json.id product.seller_products.first.seller.id
				json.name product.seller_products.first.seller.name
				json.price product.seller_products.first.price
				json.stock product.seller_products.first.stock

			end 
			# json.seller product.seller_products.size


		end


	end
end