require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET products#index' do
    it 'should render the index page' do
      allow(Stripe::Product).to receive(:list).and_return([])
      get :index
      expect(response).to render_template :index
    end
  end
  describe 'GET products#show' do
    it 'should render the show page' do
      product = double('product')
      skus = double('skus')
      allow(Stripe::Product).to receive(:retrieve).and_return(product)
      allow(product).to receive(:metadata).and_return({})
      allow(product).to receive(:name).and_return('Foo')
      allow(product).to receive(:skus).and_return(skus)
      allow(skus).to receive(:data).and_return([])
      get :show, id: 'foo'
      expect(response).to render_template :show
      expect(assigns(:product).name).to eq('Foo')
    end
  end
  describe 'GET products#subscriptions' do
    it 'should render the subscription page' do
      get :subscriptions
      expect(response). to render_template :subscriptions
    end
  end
end
