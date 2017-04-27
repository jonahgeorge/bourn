class SubscriptionsController < ApplicationController
  def new
  end

  def create
    @amount_in_cents = 100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount_in_cents,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_subscription_path
  end
end
