class PhoneVerificationsController < ApplicationController
	skip_before_action :verify_authenticity_token, :authenticate_user_from_token!, :authenticate_user!

	def verify_from_message
		user = get_user_for_phone_verification
		user.mark_phone_as_verified! if user

		render nothing: true
	end

	private

	def get_user_for_phone_verification
		phone_verification_code = params['Body'].try(:strip)
		phone_number            = params['From'].gsub('+1', '')

		search_condition = {phone_verification_code: phone_verification_code, phone: phone_number}

		User.unverified_phones.where(search_condition).first
	end
end