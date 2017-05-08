class MessagesController < ApplicationController
  skip_before_action :require_email_confirmation

  def new
    @form = ContactForm.new
    @form.name = current_user.name if is_signed_in
    @form.email = current_user.email if is_signed_in
  end

  def create
    @form = ContactForm.new(contact_form_params)
    @form.name = current_user.name if is_signed_in
    @form.email = current_user.email if is_signed_in

    if verify_recaptcha(model: @form) && @form.valid?
      MessageMailer.new_message(@form).deliver
      redirect_to new_messages_path, notice: "Your message has been sent."
    else
      render :new
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :content)
  end
end
