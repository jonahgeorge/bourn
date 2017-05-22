class SubscriptionsController < ApplicationController
  skip_before_action :require_subscription

  def new
    flash.now[:notice] = "To keep our server running, we request a small fee of $1/year."
    @form = SubscriptionForm.new
  end

  def create
    @form = SubscriptionForm.new(subscription_form_params)

    if @form.valid?
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.sources.create(source_params)

      process_subscription(current_user.stripe_id, @form.coupon)

      user = User.find(current_user.id)
      user.subscribed_until = DateTime.now + 1.year
      user.save

      flash[:notice] "Thank you for subscription! Your payment has been processed."
      redirect_to root_path
    else
      render :new
    end
  rescue Stripe::CardError => e
    flash.now[:alert] = e.message
    render :new
  end

  private

  def subscription_form_params
    params.require(:subscription_form).permit(:number, :exp_month, :exp_year, :cvc, :postal_code, :coupon)
  end

  def process_subscription(stripe_id, coupon = nil)
    params = {
      :customer => stripe_id,
      :plan     => 'standard-plan',
    }

    if coupon && !coupon.empty?
      params[:coupon] = coupon
    end

    Stripe::Subscription.create(params)
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
