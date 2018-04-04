module PagesHelper
  def starting_price(product)
    prices = product.skus.map { |p| p.price.to_f / 100 }
    number_to_currency(prices.min)
  end
end
