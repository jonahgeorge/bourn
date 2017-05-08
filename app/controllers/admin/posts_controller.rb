module Admin
  class PostsController < BaseController
    def index
      @posts = Post.all.order(created_at: :desc)
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to admin_posts_path, notice: "Successfully updated post."
      else
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.children.destroy_all
      @post.destroy

      redirect_to admin_posts_path, notice: "Successfully deleted post."
    end

    private

      def post_params
        params.require(:post).permit(:body, :is_visible)
      end
  end
end
