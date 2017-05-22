class Post < ApplicationRecord
  include PgSearch

  before_save do
    self.tags = self.body.scan(Post.tag_regex).flatten
  end

  has_many :likes

  belongs_to :user
  has_many :children, class_name: "Post", foreign_key: :parent_post_id
  has_one :parent, class_name: "Post", primary_key: :parent_post_id, foreign_key: :id

  pg_search_scope :search_for, against: :body, :using => [:tsearch, :trigram, :dmetaphone]
  validates :body, length: { minimum: 2 }

  def self.tag_regex
    /\#(\S+)/
  end

  def self.is_root_post
    where(parent_post_id: nil)
  end

  def self.visible_to(person)
    if person
      is_visible.or(Post.where(user_id: person.id))
    else
      is_visible
    end
  end

  private

    def self.is_visible
      where.not(is_visible: false)
    end
end
