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

  def plan
    plan = Stripe::Plan.create(
      :name => "Basic Plan",
      :id => "basic-monthly",
      :interval => "month",
      :currency => "usd",
      :amount => 0,
    )
  end
end
