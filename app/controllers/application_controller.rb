class ApplicationController < ActionController::API
	include ActionController::ImplicitRender
	include ActionController::MimeResponds
	include ErrorHandler
	before_action :authorize_request
	attr_reader :decoded_id, :decoded_type

	def authorize_request
		auth_header = request.headers["Authorization"]
		token = auth_header.split(' ')[1]

			puts token
			@decoded = JwtService.new().decode(token)
			@decoded_id = @decoded[0]['id']
			@decoded_type = @decoded[0]['type']


	end
end
