class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authenticate_user_from_token!, :authenticate_user!

  def index
  end

end