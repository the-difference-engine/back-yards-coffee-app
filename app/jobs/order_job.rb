class OrderJob < ApplicationJob
  queue_as :default

  def perform(subscription, customer)
    order = Stripe::Order.create(
      currency: 'usd',
      items: subscription.products['items'],
      customer: customer.stripe_customer_id,
      email: customer.email,
      shipping: {
        name: customer.full_name,
        address: customer.customer_address
      }
    )

    # choose the cheapest shipping method
    shipping_method = order.shipping_methods.find { |m| m.description == 'USPS Priority Mail' }
    if shipping_method
      order.selected_shipping_method = shipping_method.id
      order.save
    end

    # pay for the order
    order.pay(customer.stripe_customer_id)

    # update the date
    subscription.update(next_order_date: subscription.next_date)

    # save this order id in the local database
    Order.create(stripe_order_id: order.id, customer_id: customer.id)

    # send an email about the order
    OrderEmailJob.perform_later(customer, order.id)
  end
end
