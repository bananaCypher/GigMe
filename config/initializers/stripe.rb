Rails.configuration.stripe = {
    :publishable_key => 'pk_test_ayD0EZqBX60p75NRzrIQe0IY',
    :secret_key => 'sk_test_bQM1VyUQ2QaxHm357neUPjM3'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
