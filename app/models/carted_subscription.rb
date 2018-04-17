class CartedSubscription < ApplicationRecord
  belongs_to :customer #, optional: true
  # validates :plan_id, presence: { message: 'Please select a plan' }
  # validates :quantity, numericality: { greater_than: 0, message: 'Please select a quantity' }
  # scope :my_carted, ->(id) { where(status: 'carted', customer_id: id) }
end
