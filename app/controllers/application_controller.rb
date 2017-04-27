class ApplicationController < ActionController::Base
  include Pundit
  # protect_from_forgery with: :exception
  helper_method :current_user, :is_signed_in

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def is_signed_in
    session[:user_id].present?
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
