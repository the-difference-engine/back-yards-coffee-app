class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  validates_presence_of :quantity, :product_id, :sku, :customer_id, :price, :status
  validates :quantity, numericality: { greater_than: 0 }
  belongs_to :order, optional: true

  def self.my_carted(customer_id)
    carted_products = where(status: 'carted', customer_id: customer_id)
    carted_products
  end
end
