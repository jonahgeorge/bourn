class SubscriptionForm
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :number, :exp_month, :exp_year, :cvc, :postal_code, :coupon
end
