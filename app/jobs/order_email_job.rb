class OrderEmailJob < ApplicationJob
  queue_as :default

  def perform(customer, order_id)
    @order = Stripe::Order.retrieve(order_id)
    if @order.selected_shipping_method == @order.shipping_methods[0].id
      OrderMailer.send_pickup_email(customer, @order).deliver_now
    else
      OrderMailer.send_order_email(customer, @order).deliver_now
    end
  end
end
