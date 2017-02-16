class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(username, password)
    if @user.nil?
      flash[:errors] = ["Username or Password was incorrect"]
      render :new
    else
      log_in_user!(@user)
      redirect_to user_url(@user.id)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def username
    user_params[:username]
  end

  def password
    user_params[:password]
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
