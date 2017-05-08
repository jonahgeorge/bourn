class UpdateEmailForm
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email
  
  validates :email, presence: true
end
