require 'rails_helper'

RSpec.describe CartedSubscriptionsController, type: :controller do
  describe '#create' do
    context 'no current subscription' do
      it 'makes a new subscription' do
        customer = create(:customer)
        sign_in customer
        #  {"plan"=>"", "sku"=>"sku_B0DjuBqmFJ2xch", "quantity"=>"1", "product_id"=>"prod_Aux02LoK2aZg19", "name"=>"Subtle Mellow Yellow"}
        post :create, {
          plan: 'w',
          sku: 'sku_foobar',
          quantity: '1',
          product_id: 'prod_foobar',
          name: 'Foobar Blend'
        }
        expect(customer.carted_subscriptions.first.plan).to eq 'w'
        p customer.carted_subscriptions.last.products
      end
    end
  end
end
