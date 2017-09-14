class Api::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render "index.json.jbuilder"
  end

  def update
    @customer = Customer.find_by(id: params[:id])

    if @customer.update(first_name: params[:address][:first_name],
                        last_name: params[:address][:last_name],
                        address: params[:address][:address],
                        Address2: params[:address][:Address2],
                        zip_code: params[:address][:zip_code],
                        city: params[:address][:city],
                        state: params[:address][:state])

    # if customer_signed_in?
    #   customer = Stripe::Customer.retrieve(current_customer.stripe_customer_id)
    # else
    #   customer = Stripe::Customer.create(:email  => params[:stripeEmail])
    # end

    carted_products = CartedProduct.my_carted(guest_or_customer_id)

    items = carted_products.map{ |o| {type: 'sku', parent: o.sku, quantity: o.quantity } }

    order = Stripe::Order.create(
      :currency => 'usd',
      :customer => @customer.stripe_customer_id,
      :items => items,
      :shipping => {
        :name => @customer.first_name,
        :address => {
          :line1 => @customer.address,
          :city => @customer.city,
          :country => 'US',
          :postal_code => @customer.zip_code
        }
      },
    )

      render json: order
    else
      render json: @customer.errors.full_messages
    end
  end
end
