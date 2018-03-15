class CartedProduct < ApplicationRecord
  belongs_to :customer, optional: true
  validates :quantity, :product_id, :customer_id, :price, :status, presence: { message: 'Please enter all fields' }
  validates :sku, presence: { message: 'Please select a bean style' }
  validates :name, presence: { message: 'Please select a plan' }
  validates :quantity, numericality: { greater_than: 0, message: 'Please select a quantity' }
  belongs_to :order, optional: true

  def self.my_carted(customer_id)
    carted_products = where(status: 'carted', customer_id: customer_id)
    carted_products
  end
end