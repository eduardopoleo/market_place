Rails.configuration.stripe = {
  :secret_key      => ENV['stripe_secret_key'],
  :publishable_key => ENV['stripe_publishable_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end
end
