class EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def show
  end

end
