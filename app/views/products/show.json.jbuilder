json.product_json do

	json.name @product.name

	json.product_details do
		json.color @product.details["color"]
		json.department @product.details["product"]
		json.material @product.details["material"]
		json.brand @product.details["brand"]
	end
	json.sellers @product.seller_products.each do |seller_product|
		
		json.id seller_product.seller.id
		json.name seller_product.seller.name
		json.price seller_product.price
		json.stock seller_product.stock
	end


end