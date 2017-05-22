class ApplicationController < ActionController::Base
  include Pundit

  # protect_from_forgery with: :exception

  before_action :require_email_confirmation
  before_action :require_subscription

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

    def require_subscription
      if current_user.subscribed_until == nil ||
        current_user.subscribed_until < DateTime.now
          redirect_to new_subscription_path
      end
    end

    def require_email_confirmation
      if is_signed_in
        if current_user.is_email_confirmed == false
          redirect_to new_confirmation_path
        end
      end
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
