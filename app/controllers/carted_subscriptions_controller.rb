class CartedSubscriptionsController < ApplicationController
  def create
    carted_subscription = CartedSubscription.find_by(
      status: 'carted',
      customer_id: guest_or_customer_id,
      plan_id: params[:plan_id],
      grind: params[:grind]
    )
    if carted_subscription
      carted_subscription.quantity = carted_subscription.quantity.to_i + params[:quantity].to_i
    else
      plans = Stripe::Plan.list(limit: 50)
      plan = StripeTool.find_plan(plans, params[:plan_id], params[:product_id])

      carted_subscriptions = CartedSubscription.where(
          status: 'carted',
          customer_id: guest_or_customer_id
        )

      carted_subscriptions.each do |cs|
        if cs.interval_count != plan.first.interval_count || cs.interval != plan.first.interval
          flash[:error] = 'A similar plan currently exists in your cart. Please continue shopping or checkout.'
          redirect_to "/products/#{params[:product_id]}"
          return
        end
      end

      carted_subscription = CartedSubscription.new(
        quantity: params[:quantity],
        customer_id: guest_or_customer_id,
        status: 'carted',
        plan_id: params[:plan_id],
        plan_name: plan.first.id,
        grind: params[:grind],
        amount: plan[0].amount,
        interval: plan[0].interval,
        interval_count: plan[0].interval_count
      )
    end
    if carted_subscription.save
      flash[:success] = 'Product Added to Cart!'
      redirect_to '/cart'
    else
      flash[:error] = carted_subscription.errors.full_messages.join(', ').gsub(/[']/, "\\\\\'")
      if request.referer.split('/').last == 'products'
        redirect_to '/products'
      else
        redirect_to "/products/#{params[:product_id]}"
      end
    end
  end
end
