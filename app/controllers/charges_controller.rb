class ChargesController < ApplicationController
  def create
    if params[:subscription]
      carted_subscriptions = CartedSubscription.where(
        status: 'carted',
        customer_id: current_customer.id
      )
      items = []
      carted_subscriptions.each do |carted_subscription|
        items << {
          plan: carted_subscription.plan_name,
          quantity: carted_subscription.quantity
        }
      end

      begin
        Stripe::Subscription.create(
          customer: current_customer.stripe_customer_id,
          items: items
        )
      rescue
        flash[:error] = 'Error Creating Subscription'
        redirect_to '/cart'
      end
      carted_subscriptions.map do |carted_subscription|
        carted_subscription.status = 'subscribed'
        carted_subscription.save
      end
      flash[:success] = 'Charge created!'
      redirect_to '/customers/dashboard'
    else
      order = Stripe::Order.retrieve(params[:order_id])
      email = current_customer ? current_customer.email : customer_email(order.customer)
      token = params[:stripeToken]

      begin
        order.pay(source: token, email: email)
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to '/cart'
      end

      # CREATE ORDER OBJECT
      confirmed_order = Order.create(stripe_order_id: order.id, customer_id: current_customer.id)

      carted_products = CartedProduct.my_carted(guest_or_customer_id)
      carted_products.map do |carted_product|
        carted_product.status = 'product ordered'
        carted_product.order_id = confirmed_order.id
        carted_product.save
      end
      flash[:success] = 'Charge created!'
      redirect_to "/orders/#{confirmed_order.id}"
    end
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
