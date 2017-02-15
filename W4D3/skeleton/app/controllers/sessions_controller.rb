class SessionsController < ApplicationController

  before_action :redirect_to_root, only: :new, if: -> { current_user }

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if user.nil?
      flash.now[:errors] = ["Username or Password is incorrect"]
      render :new
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    # current_user.reset_session_token! if current_user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def redirect_to_root
    redirect_to cats_url
  end
end
