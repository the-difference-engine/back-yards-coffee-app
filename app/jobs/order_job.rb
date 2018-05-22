class OrderJob < ApplicationJob
  queue_as :default

  def perform(subscription, customer)
    @order = Stripe::Order.create(
      currency: 'usd',
      items: subscription.products['items'],
      customer: customer.stripe_customer_id,
      email: customer.email,
      shipping: {
        name: customer.full_name,
        address: customer.customer_address
      }
    )
  end
end
