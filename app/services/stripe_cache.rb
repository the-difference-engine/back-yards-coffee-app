class StripeCache
  def initialize; end

  def products
    Rails.cache.fetch('stripe/products', expires_in: 5.minutes) do
      Stripe::Product.list(active: true).select { |p| p.skus.data.length.positive? }
    end
  end

  def featured_products
    products.select { |product| product.metadata['featured'] }
  end
end
