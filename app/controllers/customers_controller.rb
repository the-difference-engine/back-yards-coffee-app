class CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
  end

  def index
    render 'index.html.erb'
  end
end
