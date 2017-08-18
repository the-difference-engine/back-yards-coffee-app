class CartedSubscription < ApplicationRecord

  def self.my_carted(customer_id)
    carted_subscriptions = where(status: 'carted', customer_id: customer_id)
    carted_subscriptions
  end

end
