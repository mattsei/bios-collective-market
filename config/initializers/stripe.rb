Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_API_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_API_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
STRIPE_API_PUBLIC_KEY = Rails.configuration.stripe[:publishable_key]