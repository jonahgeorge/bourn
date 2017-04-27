class Post < ApplicationRecord

  before_save do
    self.tags = self.body.scan(tag_regex).flatten
  end

  belongs_to :user
  has_many :children, class_name: "Post", primary_key: "id", foreign_key: "parent_post_id"

  def tag_regex
    /\#(\S+)/
  end

  def self.is_visible
    where(is_visible: true)
  end

  def self.is_root_post
    where(parent_post_id: nil)
  end

  # def self.has_tags
  # end
end
