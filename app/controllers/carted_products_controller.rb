class CartedProductsController < ApplicationController
  def create
    if params[:plan_id] == 'One Time Buy'
      carted_product = CartedProduct.find_by(
        status: 'carted',
        customer_id: guest_or_customer_id,
        sku: params[:sku]
      )
      if carted_product
        carted_product.quantity = carted_product.quantity.to_i + params[:quantity].to_i
      else
        carted_product = CartedProduct.new(
          quantity: params[:quantity],
          product_id: params[:product_id],
          sku: params[:sku],
          customer_id: guest_or_customer_id,
          status: 'carted',
          price: params[:price].to_i,
          name: params[:name]
        )
      end
      if carted_product.save
        flash[:success] = 'Product Added to Cart!'
        redirect_to '/cart'
      else
        flash[:error] = carted_product.errors.full_messages.join(', ').gsub(/[']/, "\\\\\'")
        redirect_to "/products/#{params[:product_id]}"
      end

    else
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
        carted_subscription = CartedSubscription.new(
          quantity: params[:quantity],
          customer_id: guest_or_customer_id,
          status: 'carted',
          plan_id: params[:plan_id],
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
        redirect_to "/products/#{params[:product_id]}"
      end
    end
  end

  def index
    @carted_products = CartedProduct.my_carted(guest_or_customer_id)
    @carted_subscriptions = CartedSubscription.my_carted(guest_or_customer_id)
    @products_total = @carted_products.sum { |s| s.price * s.quantity }
    @subscriptions_total = @carted_subscriptions.sum { |s| s.amount * s.quantity }
    @cart_total = @products_total + @subscriptions_total
    if @carted_products.empty? && @carted_subscriptions.empty?
      flash[:warning] = 'Your cart is currently empty.'
      redirect_to '/'
    end
  end
end
