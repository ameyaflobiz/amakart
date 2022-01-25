class SellerProductsController < ApplicationController
	before_action :find_product
	def register_product

		if @decoded_type == "seller"
			
			record = SellerProduct.create!(seller_product_params)

			render json: record

		else
			raise CustomException.new("--","Only Sellers can register products")
		end
	end

	def update_product

		if @decoded_type == "seller"
			
			

			seller_product = SellerProduct.find_by(product_id: @product.id, seller_id: @decoded_id)

			record = seller_product.update!(seller_product_params)

			render json: record

		else
			raise CustomException.new("--","Only Sellers can update products")
		end

	end

	private

	def seller_product_params
		params.permit(:stock,:price).merge(seller_id: @decoded_id,product_id: @product.id)
	end

	def find_product
		@product = Product.find_by(name: params[:name])
	end

end
