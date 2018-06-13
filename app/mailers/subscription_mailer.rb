class SubscriptionMailer < ApplicationMailer
  def send_subscription_confirmation_email(customer, order)
    @order = order
    @customer = customer
    mail(to: customer.email, subject: 'Subscription Confirmation')
  end

  def send_subscription_cancellation_email(customer, order)
    @order = order
    @customer = customer
    mail(to: customer.email, subject: 'Subscription Cancellation')
  end
end
