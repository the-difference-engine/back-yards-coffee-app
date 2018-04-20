require 'rails_helper'

RSpec.describe CartedSubscriptionsController, type: :controller do
  describe '#create' do
    context 'no current subscription' do
      it 'makes a new subscription' do
        customer = create(:customer)
        sign_in customer
        #  {"plan"=>"", "sku"=>"sku_B0DjuBqmFJ2xch", "quantity"=>"1", "product_id"=>"prod_Aux02LoK2aZg19", "name"=>"Subtle Mellow Yellow"}
        post :create, params: {
          plan: 'w',
          sku: 'sku_foobar',
          quantity: '1',
          product_id: 'prod_foobar',
          name: 'Foobar Blend'
        }
        expect(customer.carted_subscriptions.first.plan).to eq 'w'
      end
    end
  end
  describe '#update' do
    context 'subscriptions exist' do
      before :each do
        @customer = create(:customer)
        sign_in @customer
        @carted_subscription = create(:carted_subscription, customer: @customer)
      end
      it 'updates the products and plan columns' do
        post :update, params: {
          id: @carted_subscription.id,
          carted_subscription: {
            plan: 'b',
            products: { foo: 'bar' }.to_json
          }
        }
        carted_subscription = @customer.carted_subscriptions.last
        expect(carted_subscription.plan).to eq 'b'
        expect(JSON.parse(carted_subscription.products)).to eq('foo' => 'bar')
      end
    end
  end
end
