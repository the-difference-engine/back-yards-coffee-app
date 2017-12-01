class OrdersController < ApplicationController
  def new
    customer_id = guest_or_customer_id

    @customer =
      if customer_signed_in?
        current_customer
      else
        Customer.guest_customer?(customer_id) ? Customer.guest_customer?(customer_id) : Customer.create_guest_cutomer(customer_id)
      end

    @order = StripeTool.create_order(@customer)

    if @order[:'catch'] == 'It Broke'
      flash[:error] = @order[:order]
      redirect_to '/cart'
    else
      render '/orders/new'
    end

  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    @product_name = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.description
    @sku_price = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.amount * 0.01
    @quantity = @stripe_order.items.select { |item| item['type'] == 'sku' }.first.quantity
    @unit_price = @sku_price / @quantity
    @tax = @stripe_order.items.select { |item| item['type'] == 'tax' }.first.amount * 0.01
    @shipping = @stripe_order.items.select { |item| item['type'] == 'shipping' }.first.amount * 0.01
  end
end
