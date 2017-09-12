class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list(limit: 50)
  end

  def show
    @subscriptions=Stripe::Plan.list(limit: 50)
    @product = Stripe::Product.retrieve(id: params[:id])
    @product_plan_options = StripeTool.product_plan_options(@subscriptions, @product.id)
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list(limit: 50)
  end
end
