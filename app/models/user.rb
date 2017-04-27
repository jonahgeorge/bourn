class User < ApplicationRecord
  has_secure_password

  enum role: [ :standard, :admin ]
  has_many :posts
end
