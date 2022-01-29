module ErrorHandler
	extend ActiveSupport::Concern

	included do
		rescue_from Exception , with: :show_errors
	end

	def show_errors(exception)
		if exception.class == CustomException
			render json: 
			{ message: "Error Caught by global error handler", 
			  exception: {
				message: exception.message,
				exception: exception,
				status: exception.status,
			}}
		else
			render json:
			{ message: "Error Caught by global error handler", 
			  exception: {
				message: exception.message,
				exception: exception,
				trace: exception.backtrace
			}}
		end
	end

end