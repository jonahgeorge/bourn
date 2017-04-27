module Admin
  class PostsController < BaseController
    def index
      @posts = Post.all.order(created_at: :desc)
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
    end
  end
end
