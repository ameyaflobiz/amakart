class ProductService

	def show_product(product_id)

		@product = Product.includes(:seller_products).where(id: product_id).order("seller_products.price asc")


	end
end