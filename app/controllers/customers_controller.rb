class CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  before_action :authenticate_employee!, only: [:index]
  before_action :load_current_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.all
  end

  def show
    @subscription_items = @customer.current_subscription.products['items']
    stripe_products = Stripe::Product.list(limit: 100).data
    @subscription_items.map! do |item|
      p sku = item['parent']
      p product_id = Stripe::SKU.retrieve(sku).product
      p product_name = stripe_products.find { |p| p.id == product_id } .name
      item.merge({ 'description' => product_name })
    end
  end

  def edit; end

  def update
    if @customer.update(customer_params)
      flash[:success] = 'Shipping address updated'
      StripeTool.customer_shipping_update(@customer)
      redirect_to '/customers/dashboard'
    else
      flash[:warning] = 'Unable to update address'
      render :edit
    end
  end

  private

  def load_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(
      :first_name,
      :last_name,
      :address,
      :address2,
      :city,
      :state,
      :zip_code
    )
  end
end
