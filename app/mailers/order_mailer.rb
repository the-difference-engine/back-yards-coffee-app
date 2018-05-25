class OrderMailer < ApplicationMailer
  def send_order_email(customer, order)
    @order = order
    mail(to: customer.email, subject: 'New Wholesaler Application')
  end
end
