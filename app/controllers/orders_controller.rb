class OrdersController < ApplicationController
  def new
    customer_id = guest_or_customer_id
    @customer =
      if customer_signed_in?
        current_customer
      else
        Customer.guest_customer?(customer_id) ? Customer.guest_customer?(customer_id) : Customer.create_guest_cutomer(customer_id)
      end
  end

  def create
    if customer_signed_in?
      customer = current_customer
      customer.update(customer_params)
      @order = StripeTool.create_order(current_customer,params[:coupon])
      # else
      # TODO: GUEST ORDER
    end
    redirect_to '/orders/new'
    # TODO: REDIRECT TO ORDERS NEW
  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    # @product_name = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.description
    # @sku_price = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.amount * 0.01
    # @quantity = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.quantity
    # @unit_price = @sku_price / @quantity
    # @tax = @stripe_order.items.select { |item| item['type'] == 'tax' }.first.amount * 0.01
    # @shipping = @stripe_order.items.select { |item| item['type'] == 'shipping' }.first.amount * 0.01
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :address, :Adddress2, :city, :state, :zip_code)
  end
end
