class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sign_in(@user == current_user ? @user : current_user, :bypass => true)
      flash[:info] = "You have updated your user profile succesfully"
      redirect_to @user
    else
      flash[:danger] = "Your credentials were not updated successfully. Please try again!"
      render @user.errors
    end
  end

  def finish_signup
    if request.patch? && params[:user]
      if @user.update(user_params)
        #@user.skip_reconfirmation!
        sign_in(@user, bypass: true)
        redirect_to edit_user_registration_path
        flash[:info] = "You have updated your user profile succesfully"
      else
        @show_errors = true
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to root
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ]
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

end
