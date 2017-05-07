class User < ApplicationRecord
  has_secure_password

  enum role: [ :standard, :admin ]

  validates :email, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  has_many :posts
end
