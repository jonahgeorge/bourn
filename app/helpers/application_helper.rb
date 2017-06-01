module ApplicationHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?size=48&default=identicon&rating=pg"
  end
end
