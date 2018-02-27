require 'rails_helper'

RSpec.describe Api::ShippingCallbackController, type: :controller do
  describe 'POST shipping_callback#create' do
    let(:params) do
      {
        order: {
          id: 'fake_order_id',
          shipping: {
            name: 'Jenny Rosen',
            address: {
              line1: '1234 Main street',
              line2: nil,
              city: 'Anytown',
              state: 'CA',
              postal_code: '123456',
              country: 'US'
            }
          },
          items: [
            {
              amount: 4200,
              currency: 'usd',
              parent: {
                id: 'sku_blah_blah',
                package_dimensions: nil, # Not this one
                product: {
                  id: 'prod_blah_blah',
                  package_dimensions: { # This one
                    height: 10.0,
                    length: 3.0,
                    weight: 16.0,
                    width: 5.0
                  }
                }
              }
            }
          ],
          charge: nil
        }
      }
    end
    before :each do
      post :create, params: params, as: :json
    end
    it 'returns a json response' do
      expect(response.content_type).to eq('application/json')
    end
    it 'has the required attributes' do
      body = JSON.parse(response.body)
      expect(body).to have_key('order_update')
      expect(body['order_update']).to have_key('items')
      expect(body['order_update']).to have_key('shipping_methods')
    end
    it 'has an array in shipping_methods' do
      body = JSON.parse(response.body)
      expect(body['order_update']['shipping_methods']).to be_an(Array)
    end
    it 'has a free shipping option' do
      body = JSON.parse(response.body)
      expect(body['order_update']['shipping_methods'][0]['id']).to eq 'pick_up_shipping'
      expect(body['order_update']['shipping_methods'][0]['amount']).to eq 0
    end
  end
end
