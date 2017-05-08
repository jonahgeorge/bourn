class UpdateEmailsController < ApplicationController
  def new
    @form = UpdateEmailForm.new
  end

  def create
    @form = UpdateEmailForm.new(update_email_form_params)

    if @form.valid?
      user = User.find(current_user.id)
      user.email = @form.email
      user.email_confirmation_token = SecureRandom.urlsafe_base64.to_s
      user.is_email_confirmed = false

      if user.save
        puts user.email
        EmailConfirmationMailer.new_message(user).deliver
        redirect_to new_confirmation_path, notice: "Please check your email for confirmation instructions."
      else
        flash[:alert] = "That email is already in use."
        render :new
      end
    else
      render :new
    end
  end

  private

    def update_email_form_params
      params.require(:update_email_form).permit(:email)
    end
end
