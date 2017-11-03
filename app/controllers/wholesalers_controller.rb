class WholesalersController < ApplicationController
  before_action :authenticate_customer!, except: [:show]
  before_action :authenticate_customer_or_employee!, only: [:show]
  def index
  end

  def new
    @wholesaler = Wholesaler.new
    render 'new.html.erb'
  end

  def create
    @wholesaler = Wholesaler.create(wholesaler_params.merge(customer_id: current_customer.id))
    if @wholesaler.save
      UserMailer.send_wholesaler_email(@wholesaler).deliver_now
      render 'create.html.erb'
    else
      render 'new.html.erb'
    end
  end

  def show
    if current_employee
      @wholesaler = Wholesaler.find_by(id: params[:id])
    else
      @wholesaler = Wholesaler.find_by(id: current_customer.wholesaler.id)
    end
  end

  private

  def wholesaler_params
      params.permit(
        :business_name,
        :contact_name,
        :work_phone,
        :billing_address,
        :billing_city,
        :billing_state,
        :billing_zip_code,
        :shipping_address,
        :shipping_city,
        :shipping_state,
        :shipping_zip_code,
        :website,
        :accounts_payable_contact_name,
        :accounts_payable_contact_email,
        :accounts_payable_contact_phone,
        :retailer,
        :tax_exempt,
        :delivery_instructions,
        :recieving_hours,
        :days_closed
      )
    end
end
