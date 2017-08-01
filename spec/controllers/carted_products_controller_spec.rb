require 'rails_helper'
require 'spec_helper'

RSpec.describe CartedProductsController, type: :controller do

  xdescribe 'POST carted_products#create' do
    context 'properly assigns id for a current_customer' do
      it 'should create a CartedProduct using current_customer.id' do
        customer = create(:customer)
        sign_in customer
        post :create
        expect(assigns(:carted_product).customer_id).to eq customer.id
      end
    end
    context 'properly assigns id for an anonymous customer' do
      it 'should create a CartedProduct using session id' do
        controller.session[:session_id] = 12345
        post :create
        expect(assigns(:carted_product).customer_id).to eq 12345
      end
    end
  end

end
