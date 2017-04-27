module Admin
  class UsersController < BaseController
    def index
      @users = User.all.order(created_at: :desc)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
    end
  end
end
