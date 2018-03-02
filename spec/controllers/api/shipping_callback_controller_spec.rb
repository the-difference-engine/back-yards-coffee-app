require 'rails_helper'

RSpec.describe Api::ShippingCallbackController, type: :controller do
  describe 'POST shipping_callback#create' do
    let(:params) { build(:stripe_callback) }
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
  describe 'shipping_callback#create interaction with Shippo' do
    let(:params) { build(:stripe_callback) }
    it 'will make a ShippoService object' do
      expect(ShippoService).to receive(:new).with(instance_of(Hash))
      post :create, params: params, as: :json
    end
    it 'will combine the recieved shipping options with the pickup option' do
      shippo = double("shippo")
      allow(ShippoService).to receive(:new) { shippo }
      allow(shippo).to recieve(:create_shipment) { [:fake_option] }
      post :create, params: params, as: json
      body = JSON.parse(response.body)
      expect(body['order_update']['shipping_methods'][1]).to be :fake_option
    end
  end
end
