class ProductsController < ApplicationController

  def index
    @products = Stripe::Product.list
 end

  def show
    @products = Stripe::Product.retrieve(id: params[:id])
  end

end
