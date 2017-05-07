class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    authorize @user, :edit?
  end

  def update
    @user = User.find(params[:id])
    authorize @user, :update?

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :bio, :url, :location)
  end
end
