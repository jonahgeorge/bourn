class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def update?
    post.user_id == user.id
  end

  def edit?
    post.user_id == user.id
  end

  def destroy?
    post.user_id == user.id
  end
end
