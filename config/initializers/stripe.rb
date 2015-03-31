Rails.configuration.stripe = {
  :secret_key      => ENV['stripe_secret_key'],
  :publishable_key => ENV['stripe_publishable_key']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

