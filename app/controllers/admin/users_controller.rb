module Admin
  class UsersController < BaseController
    def index
      @users = User.all.order(created_at: :desc)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Successfully updated user."
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.posts.destroy_all
      @user.destroy

      redirect_to admin_users_path, notice: "Successfully deleted user."
    end

  private

    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
  end
end
