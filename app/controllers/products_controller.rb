class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list(limit: 50)
  end

  def show
    @subscriptions=Stripe::Plan.list(limit: 50)
    @product = Stripe::Product.retrieve(id: params[:id])
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list(limit: 50)
    p "SUBSCRIPTIONS #{@subscriptions}"
  end
end
