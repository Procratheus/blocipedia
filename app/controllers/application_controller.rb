class ApplicationController < ActionController::Base
  TEMP_EMAIL_REGEX = /\Achange@me/
  include Pundit
  protect_from_forgery with: :exception
  # Authenticated users can only access application features
  before_action :authenticate_user!
  #before_action :ensure_signup_complete
  # Configure the Devise parameters that the app will accept for authentication
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_signup_complete
    return if action_name == "finish_signup"
    if current_user && current_user.email_verified? == false
      redirect_to finish_signup_path(current_user)
    end
  end

  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email]
    devise_parameter_sanitizer.for(:account_update) << [:name, :email]
  end 

end
