# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET orders#new' do
    context 'as a guest customer' do
      session_id = '1x2x3x4x5x1x2x3x4x5x1x2x3x4x5x1x2x3x4x5x1x2x3x4x5'

      it 'should assign a customer instance using session id' do
        VCR.use_cassette('stripe_create_order') do
          get :new, session: { session_id: session_id }
        end
        expect(assigns(:customer).class).to be Customer
        expect(assigns(:customer).id).to be @controller.guest_or_customer_id
      end

      it 'should create and render a Stripe Order instance' do
        customer_id = session_id.gsub(/\D/, '').to_i / 10_000_000_000
        create(:carted_product, customer_id: customer_id)
        create(:carted_product, customer_id: customer_id, sku: 'sku_B1KMjhKL26upMH')
        VCR.use_cassette('stripe_create_order') do
          get :new, session: { session_id: session_id }
          @order = assigns(:order)
          expect(@order[:order].class).to be Stripe::Order
          expect(@order[:order].object).to be == 'order'
        end
      end
    end

    context 'as a signed in customer' do
      before :each do
        @customer = create(:customer)
        sign_in @customer
      end

      it 'should assign a customer instance using customer id' do
        VCR.use_cassette('stripe_create_order') do
          get :new
        end
        expect(assigns(:customer).class).to be Customer
        expect(assigns(:customer).id).to be @customer.id
      end

      it 'should create and render a Stripe Order instance' do
        create(:carted_product, customer_id: @customer.id)
        create(:carted_product, customer_id: @customer.id, sku: 'sku_B1KMjhKL26upMH')
        VCR.use_cassette('stripe_create_order') do
          get :new
          @order = assigns(:order)
          expect(@order[:order].class).to be Stripe::Order
          expect(@order[:order].object).to be == 'order'
        end
      end
    end
  end

  describe 'GET orders#show' do
    before :each do
      @customer = create(:customer)
      VCR.use_cassette('stripe_create_order') do
        @stripe_order = StripeTool.create_order(@customer)[:order]
      end
      sign_in @customer
      @order = Order.create(
        stripe_order_id: @stripe_order.id,
        customer_id: @customer.id
      )
    end
    it 'should assign the correct order using order id' do
      VCR.use_cassette('stripe_retrieve_order') do
        get :show, params: { id: @order.id }
      end
      expect(assigns(:order)).to eq @order
      expect(assigns(:stripe_order)).to eq @stripe_order
    end
    it 'should use the show template' do
      VCR.use_cassette('stripe_retrieve_order') do
        get :show, params: { id: @order.id }
      end
      expect(response).to render_template :show
    end
  end
end
