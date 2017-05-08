class ChangePasswordsController < ApplicationController
  def new
    @form = ChangePasswordForm.new
  end

  def create
    @form = ChangePasswordForm.new(change_password_form_params)

    if current_user.authenticate(params[:change_password_form][:old_password])
      user = User.find(current_user.id)
      user.password = @form.new_password
      if user.save
        redirect_to edit_user_path(user), notice: "Successfully updated password."
      else
        render :new
      end
    else
      flash[:alert] = "Old password is incorrect"
      render :new
    end
  end

  private

    def change_password_form_params
      params.require(:change_password_form).permit(:old_password, :new_password)
    end
end
