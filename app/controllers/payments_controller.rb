class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def create
    @payment = current_user.payments.build(amount: current_cart.total)
    stripe_payment = StripeWrapper::Charge.create(
      amount: current_cart.total,
      currency: 'usd', 
      card: params[:stripeToken] 
    )
    if stripe_payment.successful? 
      @payment.save
      redirect_to payment_completed_path
    else
      flash[:error] = stripe_payment.error_message
      render :new
    end
  end

  def payment_completed

  end
end
