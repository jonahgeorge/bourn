class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user).order(created_at: :desc)
  end
end
