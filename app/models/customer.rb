class Customer < ApplicationRecord

  has_many :carted_products
  has_many :carted_subscriptions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_commit :assign_customer_id, on: :create

  def assign_customer_id
    customer = Stripe::Customer.create(email: email)
    self.stripe_customer_id = customer.id
  end

  def subscriptions_total(id)
    @customer = Stripe::Customer.retrieve(id)
    @subscriptions_total = 0
    @customer.subscriptions.data.each do |subscription|
      @subscriptions_total += (subscription.items.data[0].quantity * (subscription.items.data[0].plan.amount * 0.01))
    end
    @subscriptions_total
  end
end
