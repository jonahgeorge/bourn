class Post < ApplicationRecord
  belongs_to :user

  def tag_regex
    /\[(.*?)\]/
  end

  def title_without_tags
    title.gsub(tag_regex, '').strip
  end

  def tags
    title.scan(tag_regex).flatten
  end

  def tags_html
    categories = %w(default primary success info warning danger)
    tags
      .map { |tag|
        classname = categories[tag.hash % 6]
        "<span class='tag tag-#{classname}'>#{tag}</span>"
      }
      .inject("", :+)
  end

  def composite_title
    title_without_tags + "&nbsp;" + tags_html
  end
end
