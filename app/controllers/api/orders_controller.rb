class Api::OrdersController < ApplicationController
  def update
    order = Stripe::Order.retrieve(params[:order_id])
    order.selected_shipping_method = params[:shipping_id]
    order.save
    render json: {order: order.shipping_methods}
  end
end
