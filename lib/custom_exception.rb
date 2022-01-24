class CustomException < StandardError

	attr_reader :status,:message

	def initialize(status,message)
		@status = status
		@message = message || "Something went wrong"
	end

end