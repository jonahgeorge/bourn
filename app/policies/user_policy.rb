class UserPolicy < ApplicationPolicy
  attr_reader :user, :other_user

  def initialize(user, other_user)
    @user = user
    @other_user = other_user
  end

  def edit?
    @other_user == @user
  end

  def update?
    @other_user == @user
  end
end
