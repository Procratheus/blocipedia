class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :ensure_signup_complete
  
  def index
  end

  def about
  end

  def contact
  end

end
