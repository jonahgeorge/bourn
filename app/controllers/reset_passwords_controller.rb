class ResetPasswordsController < ApplicationController
  def new
    @form = ResetPasswordForm.new
  end

  def create
    @form = ResetPasswordForm.new(reset_password_form_params)

    if verify_recaptcha(model: @form) && @form.valid?
      user = User.find_by(email: @form.email)

      if user
        user.password_reset_token = SecureRandom.urlsafe_base64.to_s

        if user.save
          ResetPasswordMailer.new_message(user).deliver
          redirect_to new_reset_password_path, notice: "Please check your email for password reset instructions."
        else
          flash[:alert] = "Something went wrong."
          render :new
        end
      else
        flash[:alert] = "Couldn't find an account associated with that email."
        render :new
      end
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  def edit
    @form = NewPasswordForm.new(reset_password_token: params[:reset_password_token])
  end

  def update
    @form = NewPasswordForm.new(new_password_form_params)

    user = User.find_by(password_reset_token: @form.reset_password_token)

    if user
      user.password_reset_token = nil
      user.password = @form.new_password
      user.save

      session[:user_id] = user.id

      redirect_to root_path, notice: "Successfully updated your password."
    else
      redirect_to new_reset_password_path, alert: "This token is not associated with a user."
    end
  end

  private

    def reset_password_form_params
      params.require(:reset_password_form).permit(:email)
    end

    def new_password_form_params
      params.require(:new_password_form).permit(:new_password, :reset_password_token)
    end
end
