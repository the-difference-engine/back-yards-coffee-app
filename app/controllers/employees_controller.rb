class EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def show
    @customers = Customer.all.sort
  end
end
