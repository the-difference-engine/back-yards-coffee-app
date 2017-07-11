class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  attr_accessor :price, :product_name, :total_price

  def get_values
    product = Stripe::Product.retrieve(id: self.product_id)
    sku = Stripe::SKU.retrieve(id: self.sku)
    self.price = sku.price
    self.product_name = product.name
    self.total_price = self.price * self.quantity
  end
end
