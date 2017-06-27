class ProductsController < ApplicationController
  def index
    @products = Stripe::Product.list
  end

  def show
  end

end
