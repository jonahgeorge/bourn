class SubscriptionsController < ApplicationController
  skip_before_action :require_subscription

  def new
    @form = SubscriptionForm.new
  end

  def create
    @form = SubscriptionForm.new(subscription_form_params)

    if @form.valid?
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.sources.create(source_params)
      # customer.save

      charge = process_charge(current_user.stripe_id)
      redirect_to root_path
    else
      render :new
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_subscription_path
  end

  private

  def subscription_form_params
    params.require(:subscription_form).permit(:number, :exp_month, :exp_year, :cvc, :postal_code)
  end

  def process_charge(stripe_id)
    Stripe::Charge.create(
      :customer    => stripe_id,
      :amount      => 100, # $1 in pennies
      :description => 'One year of Bourn membership',
      :currency    => 'usd'
    )
  end

  def source_params
    {
      source: {
        object: 'card',
        exp_month: @form.exp_month,
        exp_year: @form.exp_year,
        number: @form.number,
        cvc: @form.cvc,
      }
    }
  end
end
