class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Authenticated users can only access application features
  before_action :authenticate_user!
  # Configure the Devise parameters that the app will accept for authentication
  before_action :configure_permitted_parameters, if: :devise_controller?



  def ensure_signup_complete

    return if action_name == "finish_sign_up"

    if current_user && !current_user.email_verified?
      redirect_to finish_sign_up(current_user)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << [:name, :email]
  end 

end
