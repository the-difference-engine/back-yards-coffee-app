# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::CustomersController, type: :controller do
  describe 'PATCH customers#update' do
    context 'with valid customer_params' do
      it 'should create a Stripe Order object' do
        customer = create(:customer)
        valid_update_attributes = { first_name: 'John',
                                    last_name: 'Doe',
                                    address: '100 Main Strett',
                                    Address2: '',
                                    city: 'Any City',
                                    zip_code: 12_345 }
        create(:carted_product, customer_id: customer.id)
        create(:carted_product, customer_id: customer.id, sku: 'sku_B1KMjhKL26upMH')
        VCR.use_cassette('stripe_create_order') do
          patch :update, id: customer.id, customer: valid_update_attributes
          @order = assigns(:order)
          expect(@order[:order].class).to be Stripe::Order
          expect(@order[:order].object).to be == 'order'
        end
      end
    end
  end
end
