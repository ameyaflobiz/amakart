class ProductsController < ApplicationController
	before_action :is_user_product?, only: [:add_product]
	def add_product
		if is_user_product?
			# render json: params[:details]
			puts params
			@product = Product.create!(name: params[:name], details: params[:details])
			render json: @product
		else
			raise CustomException.new("raised in products controller","Buyer cannot add products")
		end
	end


	private

	def is_user_product?
		User.find(@decoded_id).user_type == "product_team"
	end


	#STRONG PARAMS GIVING JSON AS NULL ON CREATION
	# def product_params
	# 	params.permit(:name, :details)
	# end
end
