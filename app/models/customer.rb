class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_commit :assign_customer_id, on: :create

  def assign_customer_id
    customer = Stripe::Customer.create(email: email)
    self.stripe_customer_id = customer.id
  end
end
