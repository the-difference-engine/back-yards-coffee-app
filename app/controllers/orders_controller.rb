class OrdersController < ApplicationController
  def new
    params_order_id = params[:order_id]
    @stripe_order = Stripe::Order.retrieve(params_order_id)
    # This could be how to get the description
    #  i.e USPS Priority Mail Express
    @shipping = @stripe_order.items.select { |item| item.type == 'shipping' }
  end

  def create
    if customer_signed_in?
      customer = current_customer
      customer.update(customer_params)
      order_id = @order[:order]['id']
      # else
      # TODO: GUEST ORDER
      redirect_to "/orders/new?order_id=#{order_id}"
    end
    # TODO: REDIRECT TO 'ORDERS NEW
  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    @address = @stripe_order.shipping.address.line1
    @address2 = "#{@stripe_order.shipping.address.city}, #{@stripe_order.shipping.address.state} #{@stripe_order.shipping.address.postal_code}"
  end

  def update
    # TODO: GUEST ORDER
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :Address2, :city, :state, :zip_code)
  end
end
