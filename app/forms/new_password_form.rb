class NewPasswordForm
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :new_password, :reset_password_token

  validates :new_password, presence: true
  validates :reset_password_token, presence: true
end
