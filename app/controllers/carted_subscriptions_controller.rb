class CartedSubscriptionsController < ApplicationController
  def create
    carted_subscription = CartedSubscription.find_by(status: 'carted',
                                            customer_id: guest_or_customer_id,
                                            plan_id: params[:plan_id])
    if carted_subscription
      carted_subscription.quantity = carted_subscription.quantity.to_i + params[:quantity].to_i
    else
      carted_subscription = CartedSubscription.new(quantity: params[:quantity],
                                          customer_id: guest_or_customer_id,
                                          status: 'carted',
                                          plan_id: params[:plan_id],
                                          grind: params[:grind])
    end

    if carted_subscription.save
      flash[:success] = 'Product Added to Cart!'
      redirect_to '/cart'
    else
      flash[:error] = carted_subscription.errors.full_messages.join(', ').gsub(/[']/,"\\\\\'")
      redirect_to "/products/#{params[:product_id]}"
    end
  end
end
