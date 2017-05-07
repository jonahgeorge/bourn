class PostsController < ApplicationController
  def index
    @posts = Post.visible_to(current_user).is_root_post
    @posts = @posts.search_for(params[:q]) if params[:q]
    @posts = @posts.order(created_at: :desc)

    @post = Post.new
  end

  def show
    @post = Post.visible_to(current_user).find(params[:id])
    @new_post = Post.new(parent_post_id: @post.id)
  end

  def create
    @new_post = current_user.posts.build(post_params)

    if Akismet.spam?(request.ip, request.user_agent, text: params[:post][:body])
      @new_post.is_visible = false
    end

    if @new_post.save
      if params[:post][:parent_post_id]
        redirect_to post_path(params[:post][:parent_post_id])
      else
        redirect_to @new_post
      end
    else
      render :show
    end
  end

  def edit
    @post = Post.visible_to(current_user).find(params[:id])
    authorize @post, :edit?
  end

  def update
    @post = Post.visible_to(current_user).find(params[:id])
    authorize @post, :update?
    if @post.update(post_params)
      redirect_to @post, notice: "Succesfully updated post."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.visible_to(current_user).find(params[:id])
    authorize @post, :destroy?
    if @post.destroy
      redirect_to posts_path, notice: "Successfully deleted post."
    else
      render :edit
    end
  end

private

  def post_params
    params.require(:post).permit(:parent_post_id, :body)
  end
end
