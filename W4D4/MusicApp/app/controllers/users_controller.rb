class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]

    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user.id)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to bands_url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
