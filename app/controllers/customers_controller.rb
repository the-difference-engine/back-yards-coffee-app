class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :current_customer

  def show
    @customer = Customer.find_by(id: current_customer.id)
  end
end
