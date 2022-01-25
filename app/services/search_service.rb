class SearchService

	def search(search_query)
		@products = Product.where("name like ?","%#{search_query}%")
=begin
		Alternative query
		 Product.joins(seller_products: :seller)
				.select(:id,:product_id,:seller_id,:price,:stock,'products.name as product_name',
						'sellers.name as seller_name')
		 		.where("products.name like ?","%phone%")
=end
	end
end