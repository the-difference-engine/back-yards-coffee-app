class OrderMailer < ApplicationMailer
  def send_order_email(customer, order)
    @order = order
    @customer = customer
    mail(to: customer.email, subject: 'Order Confirmation')
  end

  def send_pickup_email(customer, order)
    @order = order
    @customer = customer
    mail(to: customer.email, subject: 'Order Pickup Confirmation')
  end
end
