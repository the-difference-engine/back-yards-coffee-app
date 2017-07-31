class OrdersController < ApplicationController
 
 def show
    carted_products = CartedProduct.my_carted(guest_or_customer_id)

    items = carted_products.map{ |o| {type: 'sku', parent: o.sku, quantity: o.quantity } }


    if customer_signed_in?
      customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
    else
      customer = Stripe::Customer.create(:email  => params[:stripeEmail])
    end

   @order = Stripe::Order.create(
      :currency => 'usd',
      :customer => customer.id,
      :items => items,
      :shipping => {
        :name => 'Jenny Rosen',
        :address => {
          :line1 => '1234 Main Street',
          :city => 'Anytown',
          :country => 'US',
          :postal_code => '123456'
        }
      },
    )
   p @order

    # p order.pay(:source => params[:stripeToken])
 end

end