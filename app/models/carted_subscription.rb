class CartedSubscription < ApplicationRecord
  belongs_to :customer, optional: true
  validates :plan_id, presence: { message: 'Please select a plan' }
  validates :grind, presence: { message: 'Please select a bean style' }
  validates :quantity, numericality: { greater_than: 0, message: 'Please select a quantity' }

  def self.my_carted(customer_id)
    carted_subscriptions = where(status: 'carted', customer_id: customer_id)
    carted_subscriptions
  end
end
