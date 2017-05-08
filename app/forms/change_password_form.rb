class ChangePasswordForm
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :old_password, :new_password

  validates :old_password, presence: true
  validates :new_password, presence: true
end
