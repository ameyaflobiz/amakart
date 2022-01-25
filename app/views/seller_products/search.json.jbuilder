json.search_query do 
	json.array! @products do |product|
		json.name product.name

		json.sellers product.sellers.each do |seller|

			# Converting to json object 
			seller = seller.to_json

			# Converting to seller class
			seller = JSON.parse(seller,object_class: Seller)

			# But this will create n+1 problem

			json.id seller.id
			json.name seller.name
			json.price seller.fetch_price(seller.id,product.id)
			json.stock seller.fetch_stock(seller.id,product.id)
		end


	end
end