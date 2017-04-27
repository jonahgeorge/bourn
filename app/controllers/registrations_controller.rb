class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to new_subscription_path
    else
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
