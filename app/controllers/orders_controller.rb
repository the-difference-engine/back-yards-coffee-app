class OrdersController < ApplicationController
  def show
    customer_id = guest_or_customer_id

    @customer =
      if customer_signed_in?
        current_customer
      else
        Customer.guest_customer?(customer_id) ? Customer.guest_customer?(customer_id) : Customer.create_guest_cutomer(customer_id)
      end

    @order = StripeTool.create_order(@customer)
  end
end
