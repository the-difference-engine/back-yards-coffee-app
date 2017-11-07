class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  validates_presence_of :quantity, :product_id, :customer_id, :price, :status
  validates_presence_of :sku, message: "Please enter a bean style"
  validates_presence_of :name, message: "Please enter a plan"
  validates :quantity, numericality: { greater_than: 0 }
  belongs_to :order, optional: true

  def self.my_carted(customer_id)
    carted_products = where(status: 'carted', customer_id: customer_id)
    carted_products
  end
end
