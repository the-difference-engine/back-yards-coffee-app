class ProductsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    @products = StripeCache.new.products
  end

  def show
    @product = Stripe::Product.retrieve(id: params[:id])
    if @product.metadata['plans'] && current_customer&.current_subscription&.status != 'active'
      @plans = @product.metadata.plans.split(',')
      plan_names = { w: 'Weekly', b: 'Bi-Weekly', m: 'Monthly' }
      @plans.map! { |p| [plan_names[p.to_sym], p] }
      @plans.unshift(['One Time Purchase', ''])
    end
    @skus = @product.skus.data
    @skus.select! do |sku|
      sku.inventory&.quantity&.positive? ||
        (sku.inventory.type == 'infinite')
    end
    @skus.map! do |sku|
      # product_name = @product.name
      attributes = sku.attributes.map { |pr| pr[1] } .join(', ')
      cost = number_to_currency(sku.price.to_f / 100)
      ["#{attributes} #{cost}", sku.id]
    end
    render partial: 'form_for_buying_products', layout: false if request.xhr?
  end

  def subscriptions
    @subscriptions = Stripe::Plan.list(limit: 50)
  end
end
