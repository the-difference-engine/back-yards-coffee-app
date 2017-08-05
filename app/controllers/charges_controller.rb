class ChargesController < ApplicationController
  def create
    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @amount = carted_products.sum{|s| s.price * s.quantity}

    if customer_signed_in?
      customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
      customer.sources.create({source: params[:stripeToken]})
    else
      customer = Stripe::Customer.create(
        :email  => params[:stripeEmail],
        :source => params[:stripeToken]
      )
    end

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/cart'
    else
      carted_products.each do |carted_product| carted_product.status = "product ordered"
        carted_product.save
      end
      flash[:success] = "Charge created!"
      redirect_to '/' #order/:id ?
  end
end
