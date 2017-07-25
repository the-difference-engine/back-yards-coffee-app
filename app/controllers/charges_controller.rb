class ChargesController < ApplicationController
  def create
    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @amount = carted_products.sum(&:total_price)

    if customer_signed_in?
      customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        :email  => params[:stripeEmail],
        :source => params[:stripeToken]
      )
    end

    # charge = Stripe::Charge.create(
    #   :customer    => customer.id,
    #   :amount      => @amount,
    #   :description => 'Rails Stripe customer',
    #   :currency    => 'usd'
    # )

    order = Order::Stripe.create(
      )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/cart'
    else
      flash[:success] = "Charge created!"
      # order = Order.new(charge_id: charge.id, customer_id: charge.customer, total_price:)
      redirect_to '/' #order/:id ?
  end
end
