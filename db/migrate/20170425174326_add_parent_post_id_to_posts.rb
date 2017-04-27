class AddParentPostIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :parent_post_id, :integer, allow_nil: true
  end
end
