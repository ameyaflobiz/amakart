class SearchService


	def search(params)
		# @products = Product.includes(:seller_products).where("name like ?","%#{search_query}%")
		if (page_exist?(params[:page_num]))
			raise CustomException.new(400,"Pages Out of range")
		end
		search_query = params[:search_query]
		page_num = params[:page_num] || 1
		page_num = page_num.to_i

		# puts "filtering_params" , params.slice(:brand)	
		@products = Product.includes(:seller_products).
						contains_string("#{search_query}").
						order(:id).
						page(page_num).order("seller_products.price asc")

		# filtered_params = filtering_params(params)

	 #  	filtered_params.each do |key, value|
	 #  		puts "BOOJJJACK"
	 #    	@products = @products.public_send("filter_by_#{key}", value) if value.present?
	 #    end
	 	# puts params
	 	@products = @products.filter_by_brand(params[:brand]) if params[:brand].present?
	 	@products = @products.filter_by_color(params[:color]) if params[:color].present?
	 	@products = @products.filter_by_department(params[:department]) if params[:department].present?
  	
  		@products
	end

	# def next_page(page_num)
	# 	page_num = page_num +1
	# end

	# def prev_page(page_num)
	# 	page_num = page_num -1;
	# end

	private

	def page_exist?(page_num)
		page_num = page_num.to_i
		Product.page(page_num).out_of_range?
	end

	def filtering_params(params)
		params.slice(:brand,:department,:color)
	end
end