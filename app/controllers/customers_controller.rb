class CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :current_customer

  def show
    @dashboard = true
    @customer = Customer.find_by(id: current_customer.id)
  end
end
