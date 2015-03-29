class RegistrationsController < Devise::RegistrationsController

	def edit
		puts "RegistrationsController#edit action"
	end

	def update
		puts "RegistrationsController#update action"
	end

  private

  def sign_up_params
    Rails.logger.debug("RegistrationsController.sign_up_params")
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :phone, :email, :password, :password_confirmation, :current_password)
  end

end