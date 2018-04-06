class ProductsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def index
    @products = StripeCache.new.products
  end

  def show
    @product = Stripe::Product.retrieve(id: params[:id])
    @skus = @product.skus.data
                    .select { |sku| sku.inventory.quantity.positive? }
                    .map do |sku|
                      product_name = @product.name
                      attributes = sku.attributes.map { |pr| pr.join('-') } .join(', ')
                      cost = number_to_currency(sku.price.to_f / 100)

                      ["#{product_name} #{attributes} #{cost}", sku.id]
                    end
    render partial: 'form_for_buying_products', layout: false if request.xhr?
  end

  def subscriptions
    @subscriptions = Stripe::Plan.list(limit: 50)
  end
end
