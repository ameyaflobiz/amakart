class JwtService

	def encode(payload, exp = 24.hours.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, Settings[:jwt_secret])
	end

	def decode(token)
		decoded = JWT.decode(token, Settings[:jwt_secret])
	end
end