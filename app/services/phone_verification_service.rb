class PhoneVerificationService
	attr_reader :user

	def initialize(options)
		@user = User.find(options[:user_id])
	end

	def process
		send_sms
	end

	private

	def from
		Settings.twilio_kopool_number # Add Dave Fugh's Twilio account phone number here
	end

	def to
		"+1#{@user.phone}"
	end

	def body
		"Reply with code #{@user.phone_verification_code} to verify your phone number with KO Pool."
	end

	def twilio_client
		@twilio ||= Twilio::REST::Client.new(Settings.twilio_account_sid, Settings.twilio_auth_token)
	end

	def send_sms
		Rails.logger.info "SMS: From: #{from} To: #{to} Body: \"#{body}\""

		twilio_client.account.messages.create(
			from: from,
			to: to,
			body: body
		)
	end
end