class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  attr_accessor :price, :product_name, :total_price
  validates_presence_of :quantity, :product_id, :sku, :customer_id, :status

  def stripe_attributes
    product = Stripe::Product.retrieve(id: product_id)
    product_sku = product.skus.data.detect{|o| o.id == sku}
    self.price = product_sku.price
    self.product_name = product.name
    self.total_price = price * quantity
  end

  def stripe_attr(stripe_product)
    product_sku = stripe_product.skus.data.detect{|o| o.id == sku}
    self.price = product_sku.price
    self.product_name = stripe_product.name
    self.total_price = price * quantity
  end

  def self.my_carted(customer_id)
    carted_products = where(status: 'carted', customer_id: customer_id)
    return [] if carted_products.empty?
    products = Stripe::Product.list
    carted_products.each{|o| o.stripe_attr(products.retrieve(o.product_id))}
    carted_products
  end
end
