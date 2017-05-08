class ResetPasswordMailer < ApplicationMailer
  def new_message(user)
    @user = user
    mail to: @user.email, subject: "Reset your password"
  end
end
