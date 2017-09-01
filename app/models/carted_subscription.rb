class CartedSubscription < ApplicationRecord
  belongs_to :customer, optional: true
  validates :quantity, numericality: { greater_than: 0 }

  def self.my_carted(customer_id)
    carted_subscriptions = where(status: 'carted', customer_id: customer_id)
    carted_subscriptions
  end

end
