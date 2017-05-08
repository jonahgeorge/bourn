class SessionsController < ApplicationController
  skip_before_action :require_email_confirmation

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Successfully signed in."
    else
      flash[:alert] = "Invalid email or username."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully signed out."
  end
end
