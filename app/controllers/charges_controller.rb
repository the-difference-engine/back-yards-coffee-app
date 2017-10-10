class ChargesController < ApplicationController
  def create
    carted_products = CartedProduct.my_carted(guest_or_customer_id)
    email = current_customer ? current_customer.email : params[:stripeEmail]
    order = Stripe::Order.retrieve(params[:order_id])
    token = params[:stripeToken]
    order.pay(source: token, email: email)
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to '/cart'
    else
      carted_products.each do |carted_product| carted_product.status = "product ordered"
      carted_product.save
    end
    flash[:success] = "Charge created!"
    redirect_to '/'
  end
end
