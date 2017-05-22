class AddSubscribedUntilToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribed_until, :datetime
  end
end
