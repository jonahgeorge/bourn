class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
    @post = Post.create(post_params)

    if @post.save
      redirect_to posts_path
    else
      render "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
