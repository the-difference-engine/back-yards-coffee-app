# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::CustomersController, type: :controller do
  describe 'PATCH customers#update' do
    before :each do
      @customer = create(:customer)
      create(:carted_product, customer_id: @customer.id)
      create(:carted_product, customer_id: @customer.id, sku: 'sku_B1KMjhKL26upMH')
    end

    context 'with valid customer_params' do
      valid_update_attributes = { first_name: 'John',
                                  last_name: 'Doe',
                                  address: '100 Main Strett',
                                  address2: '',
                                  city: 'Any City',
                                  zip_code: 12_345 }

      it 'should create a Stripe Order object' do
        VCR.use_cassette('stripe_create_order') do
          patch :update, params: { id: @customer.id, customer: valid_update_attributes }
          @order = assigns(:order)
          expect(@order[:order].class).to be Stripe::Order
          expect(@order[:order].object).to be == 'order'
        end
      end

      it 'should render a stripe object as a json response' do
        VCR.use_cassette('stripe_create_order') do
          patch :update, params: { id: @customer.id, customer: valid_update_attributes }
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    context 'with invalid customer_params' do
      it 'should render a 422 (unprocessable entity) error message' do
        invalid_update_attributes = { first_name: 'John',
                                      last_name: 'Doe',
                                      address: '100 Main Strett',
                                      address2: '',
                                      city: 'Any City',
                                      zip_code: '' }
        patch :update, params: { id: @customer.id, customer: invalid_update_attributes }
        expect(response.content_type).to eq('application/json')
        expect(response.status).to eq(422)
      end
    end
  end
end
