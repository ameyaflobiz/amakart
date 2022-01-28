class SearchService

	def search(search_query)
		@products = Product.includes(:seller_products).where("name like ?","%#{search_query}%")

	end
end