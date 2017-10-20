class CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  before_action :authenticate_employee_admin!, only: [:index]
  def index
    @customers = Customer.all
  end
  def show
    @customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
  end
end