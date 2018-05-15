class PagesController < ApplicationController
  def index
    @products = StripeCache.new.featured_products
  end

  def about
    @editables = Editable.first
  end

  def coffee_club
    @products = Stripe::Product.list(active: true)
                               .select { |product| product.attributes.include?('featured') }
    @subscriptions = Stripe::Plan.list(limit: 50)
  end

  def menu
    @categories = Category.all
  end

  def contact
  end

  def faqs
  end
end
