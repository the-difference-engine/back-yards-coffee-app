class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list(limit: 50)
  end

  def show
    @subscriptions=Stripe::Plan.list(limit: 50)
    @product = Stripe::Product.retrieve(id: params[:id])
    all_plans=Stripe::Plan.list
    @product_plan_options = StripeTool.product_plan_options(all_plans, @product.id)
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list(limit: 50)
    p "SUBSCRIPTIONS #{@subscriptions}"
  end
end
