class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :latitude, :longitude, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :latitude, :longitude, :address])
  end

  def authenticate_admin!
    if current_user.admin? == false
      flash[:notice] = "You must be an admin to order to access that!"
      redirect_to "/"
    end
  end

end


