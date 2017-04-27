class PostsController < ApplicationController
  def index
    @posts = Post
      .is_visible
      .is_root_post
      .order(created_at: :desc)

    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @new_child_post = Post.new
  end

  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      @new_child_post = current_user.posts.build(post_params)
      @new_child_post.parent_post_id = @post.id
      if @new_child_post.save
        redirect_to post_path(params[:post_id])
      else
        render :show
      end
    else
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to posts_path
      else
        render :new
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post, :edit?
  end

  def update
    @post = Post.find(params[:id])
    authorize @post, :update?
    if @post.update(post_params)
      redirect_to @post, notice: "Succesfully updated post."
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post, :destroy?
    if @post.destroy
      redirect_to posts_path, notice: "Successfully deleted post."
    else
      render :edit
    end
  end

private

  def post_params
    params.require(:post).permit(:body)
  end
end
