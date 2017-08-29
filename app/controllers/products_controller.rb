class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list
  end

  def show
    @product = Stripe::Product.retrieve(id: params[:id])
    all_plans=Stripe::Plan.list
    @product_plans = StripeTool.product_plans(all_plans, @product.id)
    @product_plan_options = StripeTool.product_plan_options(all_plans, @product.id)
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list
    p "SUBSCRIPTIONS #{@subscriptions}"
  end
end
