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
    StripeTool.customer_shipping_update(@customer)
    if params[:subscription]
      valid_shipping_address = @customer.valid_shipping_address?
      render json: { 
        customer: @customer, 
        valid_shipping_address: valid_shipping_address 
      }
    else
      @order = StripeTool.create_order(@customer)
      render json: @order
    end
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
