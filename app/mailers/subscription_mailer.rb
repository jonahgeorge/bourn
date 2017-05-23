class SubscriptionMailer < ApplicationMailer
  def new_message(user)
    @user = user
    mail to: @user.email, subject: "Thank you for subscribing to Bourn"
  end
end
