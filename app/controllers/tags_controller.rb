class TagsController < ApplicationController
  def index
    @tags = Post.select('distinct unnest(tags)').all.
      map { |p| p[:unnest] }

    render json: @tags
  end
end
