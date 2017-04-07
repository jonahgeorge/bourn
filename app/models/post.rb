class Post < ApplicationRecord
  belongs_to :user

  before_save do
    self.tags = self.body.scan(tag_regex).flatten
  end

  def tag_regex
    /\#(\S+)/
  end
end
