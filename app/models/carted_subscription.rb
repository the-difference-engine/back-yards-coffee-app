class CartedSubscription < ApplicationRecord
  belongs_to :customer, optional: true
  # validates :plan_id, presence: { message: 'Please select a plan' }
  # validates :quantity, numericality: { greater_than: 0, message: 'Please select a quantity' }
  # scope :my_carted, ->(id) { where(status: 'carted', customer_id: id) }
  after_initialize :init

  def init
    self.products = { items: [] } unless products['items']
    self.status ||= 'pending'
  end

  def add_item(params)
    self.plan = params[:plan]
    item_index = products['items'].find_index do |item|
      item['parent'] == params[:sku]
    end
    if item_index
      products['items'][item_index]['quantity'] += params[:quantity].to_i
    else
      products['items'] << {
        type: 'sku',
        parent: params[:sku],
        quantity: params[:quantity].to_i
      }
    end
  end

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
