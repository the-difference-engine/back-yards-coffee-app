class OrdersController < ApplicationController
  def new
    @first_name = current_customer.first_name.capitalize
    @last_name = current_customer.last_name.capitalize
  

    # @order = Order.find(params[:id])
    # @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)

     # this goes over the last erb tag
     # <%= hidden_field_tag :order_id, @order[:order].id %>
  end
  
  def create
    if customer_signed_in?
      customer = current_customer
      customer.update(customer_params)
      @order = StripeTool.create_order(current_customer)
      # else
      # TODO: GUEST ORDER
    end
    redirect_to '/cart'
    # TODO: REDIRECT TO ORDERS NEW
  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)


    @address = @stripe_order.shipping.address.line1
    @address2 = "#{@stripe_order.shipping.address.city}, #{@stripe_order.shipping.address.state} #{@stripe_order.shipping.address.postal_code}"
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :Adddress2, :city, :state, :zip_code)
  end
end
