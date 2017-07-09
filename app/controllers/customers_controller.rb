class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :current_customer

  def show
    @dashboard = true
    @customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
  end
end
