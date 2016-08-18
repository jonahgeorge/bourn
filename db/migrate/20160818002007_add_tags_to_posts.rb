class AddTagsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :tags, :string, array: true, default: []
    add_index :posts, :tags, using: 'gin'

    tag_regex = /\[(.*?)\]/
    Post.all.each do |post|
      tags = post.title.scan(tag_regex).flatten
      post.title = post.title.gsub(tag_regex, "").strip
      post.tags = tags
      post.save
    end
  end
end
