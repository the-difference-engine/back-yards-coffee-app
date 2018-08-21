class ChargesController < ApplicationController
  def create
    order = Stripe::Order.retrieve(params[:order_id])
    email = current_customer ? current_customer.email : customer_email(order.customer)
    token = params[:stripeToken]

    begin
      order.pay(source: token, email: email)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      return redirect_to '/cart'
    end

    # CREATE ORDER OBJECT
    confirmed_order = Order.create(stripe_order_id: order.id, customer_id: guest_or_customer_id)

    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    carted_products.map do |carted_product|
      carted_product.status = 'product ordered'
      carted_product.order_id = confirmed_order.id
      carted_product.save
    end

    p current_customer
    p current_customer.current_subscription
    subscription = current_customer.current_subscription
    p subscription
    if subscription.status == 'pending' && subscription.quantity != 0
      p 'pending'
      subscription.status = 'active'
      subscription.order_created_at = Time.zone.today
      subscription.next_order_date = subscription.next_date
      subscription.save
      customer = Stripe::Customer.retrieve(order.customer)
      customer.source = token
      customer.save
    end

    OrderEmailJob.perform_later(current_customer, order.id)
    flash[:success] = 'Charge created!'
    redirect_to "/orders/show/#{confirmed_order.id}"
  end

  private

  def customer_email(stripe_customer_id)
    email = params[:stripeEmail]
    customer = Customer.find_by(stripe_customer_id: stripe_customer_id)
    customer.update(email: email)
    stripe_customer = Stripe::Customer.retrieve(stripe_customer_id)
    stripe_customer.email = email
    stripe_customer.save
    email
  end
end
