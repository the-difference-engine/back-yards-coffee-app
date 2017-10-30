class SubscriptionsController < ApplicationController
  def new
    subscription = Subscription.find_by(status: 'carted',
                                            customer_id: customer_id,
                                            plan_id: params[:plan_id],
                                            grind: params[:grind])
    if subscription
      subscription.quantity = subscription.quantity.to_i + params[:quantity].to_i
    else
      plans = Stripe::Plan.list(limit: 50)
      plan = StripeTool.find_plan(plans, params[:plan_id], params[:product_id])
      subscription = Subscription.new(quantity: params[:quantity],
                                          customer_id: customer_id,
                                          status: 'carted',
                                          plan_id: params[:plan_id],
                                          grind: params[:grind],
                                          amount: plan[0].amount,
                                          interval: plan[0].interval,
                                          interval_count: plan[0].interval_count)
    end

    if subscription.save
      flash[:success] = 'Subscription Added to Cart!'
      redirect_to '/cart'
    else
      flash[:error] = subscription.errors.full_messages.join(', ').gsub(/[']/,"\\\\\'")
      redirect_to "/products/#{params[:product_id]}"
    end
  end
end
