class PagesController < ApplicationController
  def index
    @products = Stripe::Product.list.select{|product| product.attributes.include?('featured')}
    @subscriptions = Stripe::Plan.list(limit: 50)
  end
  def about
  end
  def coffee_club
    @products = Stripe::Product.list.select{|product| product.attributes.include?('featured')}
    @subscriptions = Stripe::Plan.list(limit: 50)
  end
  def coffee_house
  end
end
