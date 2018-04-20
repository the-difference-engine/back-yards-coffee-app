class CartedSubscription < ApplicationRecord
  belongs_to :customer, optional: true
  # validates :plan_id, presence: { message: 'Please select a plan' }
  # validates :quantity, numericality: { greater_than: 0, message: 'Please select a quantity' }
  # scope :my_carted, ->(id) { where(status: 'carted', customer_id: id) }

  def next_date
    today = Date.today
    case plan
    when 'w'
      today + 7
    when 'b'
      today + 14
    when 'm'
      Date.new(today.year, today.month + 1, today.day)
    end
  end
end
