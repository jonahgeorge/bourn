class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :is_signed_in

  def current_user
    User.find(session[:user_id])
  end

  def is_signed_in
    session[:user_id].present?
  end
end
