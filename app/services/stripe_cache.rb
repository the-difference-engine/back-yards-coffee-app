class StripeCache
  def initialize

  end

  def products
    Rails.cache.fetch('stripe/products', expires_in: 5.minutes) do
      Stripe::Product.list
    end
  end

  def featured_products
    products.select { |p| p.attributes.include?('featured') }
  end
end
