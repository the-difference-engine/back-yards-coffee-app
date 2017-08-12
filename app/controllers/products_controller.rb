class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list
  end

  def show
    @product = Stripe::Product.retrieve(id: params[:id])
  end

  def subscriptions
    @subscriptions=Stripe::Plan.list
  end 
end
