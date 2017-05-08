class SubscriptionsController < ApplicationController
  skip_before_action :require_subscription

  def new
  end

  def create
  #   @amount_in_cents = 100
  #
  #   cu = Stripe::Customer.retrieve(current_user.stripe_id)
  #   cu.save
  #
  #   charge = Stripe::Charge.create(
  #     :customer    => current_user.stripe_id,
  #     :amount      => @amount_in_cents,
  #     :description => 'Rails Stripe customer',
  #     :currency    => 'usd'
  #   )
  #
  #   redirect_to root_path
  # rescue Stripe::CardError => e
  #   flash[:error] = e.message
  #   redirect_to new_subscription_path
  end
end
