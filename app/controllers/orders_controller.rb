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
  end

  def show
    @order = Order.find(params[:id])
    @stripe_order = Stripe::Order.retrieve(@order.stripe_order_id)
    @tax = @stripe_order.items.select{|item| item["type"] == "tax" }.first.amount
  end
end