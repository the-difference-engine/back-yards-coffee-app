class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end

  def update
    @customer = Customer.find_by(id: params[:id])
    unless @customer.update(customer_params)
      render json: { errors: @customer.errors.full_messages }, status: 422
      return
    end
    @order = StripeTool.create_order(@customer)
    render json: @order
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name,
                                     :last_name,
                                     :address,
                                     :Address2,
                                     :city,
                                     :state,
                                     :zip_code)
  end
end
