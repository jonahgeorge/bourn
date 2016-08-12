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

  def composite_title
    html_tags = tags.map { |t| "<span class='tag tag-primary'>#{t}</span>" }.inject("", :+)
    title_without_tags + "&nbsp;" + html_tags
  end
end
