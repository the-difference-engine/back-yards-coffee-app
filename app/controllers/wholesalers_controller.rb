class WholesalersController < ApplicationController
  def index
  end
  def new
    @wholesaler = Wholesaler.new
    render 'new.html.erb'
  end

 def create
  @wholesaler = Wholesaler.new(
    business_name: params[:form_business_name],
    contact_name: params[:form_contact_name],
    work_phone: params[:form_work_phone],
    billing_address: params[:form_billing_address],
    billing_city: params[:form_billing_city],
    billing_state: params[:form_billing_state],
    billing_zip_code: params[:form_billing_zip_code],
    shipping_address: params[:form_shipping_address],
    shipping_city: params[:form_shipping_city],
    shipping_state: params[:form_shipping_state],
    shipping_zip_code: params[:form_shipping_zip_code],
    website: params[:form_website],
    accounts_payable_contact_name: params[:form_accounts_payable_contact_name],
    accounts_payable_contact_email:
    params[:form_accounts_payable_contact_email],
    accounts_payable_contact_phone:
    params[:form_accounts_payable_contact_phone],
    retailer: params[:form_retailer],
    tax_exempt: params[:form_tax_exempt],
    delivery_instructions:
    params[:form_delivery_instructions],
    recieving_hours: params[:form_recieving_hours],
    days_closed: params[:form_days_closed]
  )
    if @wholesaler.save
      render 'create.html.erb'
    else
      render 'new.html.erb'
    end
  end
end
