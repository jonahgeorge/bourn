class AddPostsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :user

    user = User.find_by(email: "jonah.george@me.com")
    Post.all.each do |post|
      post.user_id = user.id
      post.save
    end
  end
end
