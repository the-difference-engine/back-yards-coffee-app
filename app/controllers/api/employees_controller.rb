class Api::EmployeesController < ApplicationController
  def index
    @employees = Employee.all
    render "index.json.jbuilder"
  end
end
