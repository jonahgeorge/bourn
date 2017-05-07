class MessagesController < ApplicationController
  def new
    @message = Message.new
    @message.name = current_user.name if is_signed_in
    @message.email = current_user.email if is_signed_in
  end

  def create
    @message = Message.new(message_params)
    @message.name = current_user.name if is_signed_in
    @message.email = current_user.email if is_signed_in

    if @message.valid?
      MessageMailer.new_message(@message).deliver
      redirect_to new_messages_path, notice: "Your message has been sent."
    else
      flash[:alert] = "An error occurred while delivering this message."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end
