class PagesController < ApplicationController
  def index
    @products = Stripe::Product.list.select { |product| product.attributes.include?('featured') }
    @subscriptions = Stripe::Plan.list(limit: 50)
  end

  def about; end

  def coffee_club
    @products = Stripe::Product.list.select { |product| product.attributes.include?('featured') }
    @subscriptions = Stripe::Plan.list(limit: 50)
  end

  def coffee_house
    @categories = Category.all
  end

  def contact
    render 'contact.html.erb'
  end

  def faqs
    render 'faqs.html.erb'
  end
end
