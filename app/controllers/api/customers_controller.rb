class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end

  def update
    @customer = Customer.find_by(id: params[:id])

    full_name = "#{params[:address][:first_name]} #{params[:address][:last_name]}"

    begin
      address_from = Shippo::Address.create(
        name: full_name,
        street1: params[:address][:address],
        street2: params[:address][:Address2],
        city: params[:address][:city],
        state: params[:address][:state],
        zip: params[:address][:zip_code],
        country: 'US',
        validate: true
      )

      if address_from.validation_results.is_valid
        @customer.update(
          address: address_from.street1,
          address2: address_from.street2,
          city:  address_from.city,
          zip_code: address_from.zip,
          state: address_from.state
        )
      else
        render json: address_from
      end
    rescue
      render json: { error: 'Shippo API error', code: 500 }
    end

  end
end