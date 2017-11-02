class ProductsController < ApplicationController
  def index
    @products = Stripe::Product.list(limit: 50)
  end

  def show
    @subscriptions = Stripe::Plan.list(limit: 50)
    @product = Stripe::Product.retrieve(id: params[:id])
    @product_plan_options = StripeTool.product_plan_options(@subscriptions, @product.id)
    @product_plan_options.push('One Time Buy')
    # if request.xhr?
      # render partial(params: [@product: @product])
  end

  def subscriptions
    @subscriptions = Stripe::Plan.list(limit: 50)
  end

  def from_id
    @selected =  Striepe::Product.where()

  end
end
