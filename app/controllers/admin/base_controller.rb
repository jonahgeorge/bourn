module Admin
  class BaseController < ::ApplicationController
    layout "admin"

    before_action :check_role

    private

    def check_role
      if current_user.nil? || current_user.role != "admin"
        flash[:danger] = "Not authorized."
        redirect_to root_path
      end
    end
  end
end
