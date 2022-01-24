class ApplicationController < ActionController::API
	include ErrorHandler
	before_action :authorize_request
	attr_reader :decoded_id

	def authorize_request
		auth_header = request.headers["Authorization"]
		token = auth_header.split(' ')[1]

		begin

			@decoded = JwtService.new().decode(token)
			@decoded_id = @decoded[0]['id']

		rescue ActiveRecord::RecordNotFound => error

			render json: { errors: error.message }, status: :unauthorized

		rescue JWT::DecodeError => error

			render json: { errors: error.message}, status: :unauthorized

		end
	end
end
