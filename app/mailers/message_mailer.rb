class MessageMailer < ApplicationMailer
  default to: 'team@jonahgeorge.com'

  def new_message(message)
    @message = message
    mail subject: "Message from #{message.name}"
  end
end
