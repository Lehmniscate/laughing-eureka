class UsersController < ApplicationController

  before_action :redirect_to_root, only: :new, if: -> { current_user }

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def redirect_to_root
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
