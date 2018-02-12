class Api::ProductsController < ApplicationController
  def index
    @products = Stripe::Product.list
    render "index.json.jbuilder"
  end
end
