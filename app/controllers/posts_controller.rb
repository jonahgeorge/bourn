class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path
    else
      render "new"
    end
  end

  def edit
    @post = authorize Post.find(params[:id])
  end

  def update
    @post = authorize Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: "Succesfully updated post."
    else
      render "edit"
    end
  end

  def destroy
    @post = authorize Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "Successfully deleted post."
    else
      render "edit"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :created_at)
  end
end
