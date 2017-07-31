class ChargesController < ApplicationController
  def create
    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @amount = carted_products.sum(&:total_price)

    if customer_signed_in?
      customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
      customer.sources.create({source: params[:stripeToken]})
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

    #   "object": "order_item",
    #   "amount": 1500,
    #   "currency": "usd",
    #   "description": "T-shirt",
    #   "parent": "sk_1AU2CdD5v3nurHsL1ybBeRBG",
    #   "quantity": null,
    #   "type": "sku"

    items = [{"object": "order_item","amount": 1500,"parent": "sk_1AU2CdD5v3nurHsL1ybBeRBG","type": "sku"}]
    # order = Order::Stripe.create(currency: 'usd',items: items)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/cart'
    else
      carted_products.each do |carted_product| carted_product.status = "product ordered"
        carted_product.save
      end
      flash[:success] = "Charge created!"
      # order = Order.new(charge_id: charge.id, customer_id: charge.customer, total_price:)
      redirect_to '/' #order/:id ?
  end
end
