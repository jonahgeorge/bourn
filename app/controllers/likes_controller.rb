class LikesController < ApplicationController
  def create
    @like = Like.new(
      user_id: current_user.id,
      post_id: params[:post_id]
    )

    if @like.save
    else
    end
  end

  def destroy
    @like = Like.find(params[:id])
    authorize @like, 'delete'
    @like.destroy
  end

  private

  def like_params
  end
end


