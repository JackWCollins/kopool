class RegistrationsController < Devise::RegistrationsController
  before_filter :require_user, only: [:edit, :update]

	def edit
		puts "RegistrationsController#edit action"
    @user = current_user
    respond_to do | format |
      format.json {render json: @user}
    end
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