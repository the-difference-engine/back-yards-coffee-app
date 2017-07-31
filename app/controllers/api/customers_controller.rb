class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end
end
