class PaymentsController < ApplicationController
  def new
    @payment = Payment.new
  end

  def index
    @payments = Payment.all
  end

  def create
    stripe_payment = StripeWrapper::Charge.create(
      amount: current_cart.total,
      currency: 'usd', 
      card: params[:stripeToken] 
    )
    if stripe_payment.successful? 
      @payment = Payment.create(
        user: current_user,
        amount: current_cart.total,
        cart: current_cart,
        reference_id: payment_id(stripe_payment))
        current_cart.update_attribute(:active, false)
        session[:cart_id] = nil
        redirect_to payments_path
    else
      @payment = Payment.new
      flash[:error] = stripe_payment.error_message
      render :new
    end
  end

  private
  def payment_id(stripe_response)
    (JSON.parse stripe_response.response.to_s)['id']
  end
end
