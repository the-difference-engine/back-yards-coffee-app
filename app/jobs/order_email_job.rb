class OrderEmailJob < ApplicationJob
  queue_as :default

  def perform(customer, order_id)
    order = Stripe::Order.retrieve(order_id)
    OrderMailer.send_order_email(customer, order)
  end
end
