class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end

  def update
    p params

    @customer = Customer.find_by(id: params[:id])

    if @customer.update(first_name: params[:first_name],
                        last_name: params[:last_name],
                        address: params[:address],
                        Address2: params[:Address2],
                        zip_code: params[:zip_code],
                        city: params[:city],
                        state: params[:state])
      render json: @customer
    else
      render json: @customer.errors.full_messages
    end
  end
end
