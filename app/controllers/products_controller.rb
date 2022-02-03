class ProductsController < ApplicationController
	skip_before_action :authorize_request, only: [:search]
	before_action :is_user_product_team_member?, only: [:add_product]

	def index

		@products = SearchService.new().search(index_params)

	end

	def show

		@product = ProductService.new().show_product(params[:id])[0]

	end

	def add_product
		
		if !is_user_product_team_member?
			raise CustomException.new(400,"Buyer cannot add products")
		end
	
		product = Product.create!(name: params[:name], details: params[:details])
		files = params[:files]
		if files.present?
			ActiveRecord::Base.transaction do
				files.each do |file|
					upload = @product.images.create!(file: file)
				end
			end
		end
		render json: product

	end

	def add_images

		if is_user_product_team_member?
			@product = Product.find(params[:id])
			files = params[:files]
			ActiveRecord::Base.transaction do
				files.each do |file|
					upload = @product.images.create!(file: file)
				end
			end
		end
		render json: params[:files]
	end

	def search
		#apply index and filtering
		@products = SearchService.new().search(params)
	end


	private

	def is_user_product_team_member?
		User.find(@decoded_id).user_type == "product_team"
	end

	def index_params
		params.permit(:search_query,:page_num)
	end

	#STRONG PARAMS GIVING JSON AS NULL ON CREATION
	# def product_params
	# 	params.permit(:name, :details)
	# end
end
