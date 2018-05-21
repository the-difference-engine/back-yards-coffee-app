module PagesHelper
  def starting_price(product)
    prices = product.skus.data.map { |p| p.price.to_f / 100 }
    number_to_currency(prices.min)
  end
end
