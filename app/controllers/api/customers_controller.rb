class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end

  def update
    @customer = Customer.find_by(id: params[:id])
    unless @customer.update(customer_params)
      render json: { error: @customer.errors.full_messages, code: 500 }
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
