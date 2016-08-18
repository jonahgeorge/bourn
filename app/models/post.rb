class Post < ApplicationRecord
  belongs_to :user

  def tags_list
    self[:tags].join(", ")
  end

  def tags_list=(names)
    self[:tags] = names.split(",").map(&:strip)
  end

  def tags_html
    categories = %w(default primary success info warning danger)
    tags
      .map { |tag|
        classname = categories[tag.hash % 6]
        "<span class='tag tag-#{classname}'>#{tag}</span>"
      }
      .join(" ")
  end
end
