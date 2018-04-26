class OrderMailer < ApplicationMailer
  def send_order_email(customer, order)
    @order = order
    puts "THIS IS WHERE I WOULD TOTALLY EMAIL #{customer.email} about:"
    p @order.to_s
    mail(to: customer.email, subject: 'New Wholesaler Application')
  end
end
