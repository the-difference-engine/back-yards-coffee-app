class OrderMailer < ApplicationMailer
  def send_order_email(customer, order)
    @order = order
    @customer = customer
    @sku_objects = StripeTool.get_sku_objects(order)
    mail(to: customer.email, subject: 'Order Confirmation')
  end

  def send_pickup_email(customer, order)
     @order = order
     @customer = customer
     @sku_objects = StripeTool.get_sku_objects(order)
    mail(to: customer.email, subject: 'Order Pickup Confirmation')
  end

  def send_order_email_client(customer,employee, order)
    @order = order
    @customer = customer
    @sku_objects = StripeTool.get_sku_objects(order)
    mail(to: employee.email, subject: 'Shipping Scheduled')
  end

  def send_pickup_email_client(customer,employee, order)
    @order = order
    @customer = customer
    @sku_objects = StripeTool.get_sku_objects(order)
    mail(to: employee.email, subject: 'Pickup Scheduled')
  end
end
