json.search_query do 
	json.array! @products do |product|
		json.name product.name

		json.sellers product.seller_products.each do |seller_product|

			# But this will create n+1 problem
			json.id seller_product.seller.id
			json.name seller_product.seller.name
			json.price seller_product.price
			json.stock seller_product.stock
		end


	end
end