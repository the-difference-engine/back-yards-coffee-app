class ProductsController < ApplicationController
  def index
    @products = StripeCache.new.products
  end

  def show
    @subscriptions = Stripe::Plan.list(limit: 50).data
    @product = Stripe::Product.retrieve(id: params[:id])

    @subscriptions = @subscriptions.select { |sub| sub['metadata'].to_h.present? && sub['metadata'].prod_id == @product.id }
    @product_plan_options = StripeTool.product_plan_options(@subscriptions, @product.id)
    @product_plan_options.push('One Time Buy')
    render partial: 'form_for_buying_products', layout: false if request.xhr?
  end

  def subscriptions
    @subscriptions = Stripe::Plan.list(limit: 50)
  end
end
