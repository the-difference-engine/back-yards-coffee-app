class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list
  end

  def show
    @subscriptions=Stripe::Plan.list
    @product = Stripe::Product.retrieve(id: params[:id])
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list
    p "SUBSCRIPTIONS #{@subscriptions}"
  end
end
