class ApplicationController < ActionController::API
	before_action :authorize_request
	attr_reader :current_user_id

	def authorize_request
		auth_header = request.headers["Authorization"]
		token = auth_header.split(' ')[1]

		begin

			@decoded = JwtService.new().decode(token)
			@current_user_id = @decoded[0]['user_id']

		rescue ActiveRecord::RecordNotFound => error

			render json: { errors: error.message }, status: :unauthorized

		rescue JWT::DecodeError => error

			render json: { errors: error.message}, status: :unauthorized
			
		end
	end
end
