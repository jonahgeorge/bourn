class EmailConfirmationMailer < ApplicationMailer
  def new_message(user)
    @user = user
    mail to: @user.email, subject: "Confirm your email address"
  end
end
