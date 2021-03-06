class ConfirmationsController < ApplicationController
  skip_before_action :require_email_confirmation

  def new
    @form = EmailConfirmationForm.new

    if is_signed_in && current_user.email_confirmation_token == nil
      user = User.find(current_user.id)
      user.email_confirmation_token = SecureRandom.urlsafe_base64.to_s
      user.save

      EmailConfirmationMailer.new_message(user).deliver
    end
  end

  def create
    @form = EmailConfirmationForm.new(email_confirmation_form_params)

    if verify_recaptcha(model: @form) && @form.valid?
      user = User.find_by(email: @form.email)
      user.email_confirmation_token = SecureRandom.urlsafe_base64.to_s

      if user.save
        EmailConfirmationMailer.new_message(user).deliver
        redirect_to new_confirmation_path, notice: "Please check your email for confirmation instructions."
      else
        flash[:alert] = "Something bad happened :("
        render :new
      end
    else
      render :new
    end
  end

  def show
    user = User.find_by(email_confirmation_token: params[:email_token])

    if user
      user.email_confirmation_token = nil
      user.is_email_confirmed = true
      user.save

      session[:user_id] = user.id

      redirect_to root_path, notice: "Successfully confirmed your email address."
    else
      redirect_to new_confirmation_path, alert: "This token is not associated with a user."
    end
  end

  private

    def email_confirmation_form_params
      params.require(:email_confirmation_form).permit(:email)
    end
end
