class AddIsVisibleToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_visible, :boolean, default: true
  end
end
