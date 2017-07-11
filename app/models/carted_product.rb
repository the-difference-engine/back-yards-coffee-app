class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  attr_accessor :price, :product_name, :total_price
  validates_presence_of :quantity, :product_id, :sku, :user_id, :status

  def stripe_attributes
    product = Stripe::Product.retrieve(id: product_id)
    product_sku = Stripe::SKU.retrieve(id: sku)
    self.price = product_sku.price
    self.product_name = product.name
    self.total_price = price * quantity
  end
end
