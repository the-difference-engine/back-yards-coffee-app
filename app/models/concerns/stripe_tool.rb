module StripeTool

  # returns the quantity for a Stripe Product object
  def self.product_quantity(product)
    product.skus.data[0].inventory.quantity + 1
  end

end