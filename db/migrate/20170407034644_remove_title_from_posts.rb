class RemoveTitleFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :title
  end
end
