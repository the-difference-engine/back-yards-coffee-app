# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  xdescribe 'GET orders#create' do
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

  xdescribe 'GET orders#show' do
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
