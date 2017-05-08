class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.email_confirmation_token = SecureRandom.urlsafe_base64.to_s

    if @user.valid?
      customer = Stripe::Customer.create(email: params[:user][:email])
      @user.stripe_id = customer.id
    end

    if verify_recaptcha(model: @user) && @user.save
      EmailConfirmationMailer.new_message(@user).deliver

      flash[:notice] = "Please confirm your email address before logging in."
      redirect_to new_session_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
