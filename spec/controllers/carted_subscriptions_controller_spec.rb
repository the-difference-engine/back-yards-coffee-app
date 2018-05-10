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
            plan: 'b'
          }
        }
        carted_subscription = @customer.carted_subscriptions.last
        expect(carted_subscription.plan).to eq 'b'
      end
    end
  end
  describe '#index' do
    context 'not signed in' do
      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to('/customers/sign_in')
      end
    end
    context 'signed in' do
      before :each do
        @customer = create(:customer)
        sign_in @customer
        create(:carted_subscription, customer: @customer)
        create(:carted_subscription, customer: @customer, status: 'active')
      end
      it 'assigns the current subscription and history' do
        get :index
        expect(assigns(:subscriptions)).to all(be_a CartedSubscription)
        expect(assigns(:subscription)).to be_a CartedSubscription
        expect(assigns(:items)).to be_an Array
      end
    end
  end
  describe '#destroy' do
    before :each do
      @customer = create(:customer)
      sign_in @customer
      @carted_subscription = create(:carted_subscription, customer: @customer)
    end
    it 'sets the subscription status to inactive and saves the time' do
      post :destroy, params: {
        id: @carted_subscription.id
      }
      @carted_subscription.reload
      expect(@carted_subscription.status).to eq 'inactive'
      expect(@carted_subscription.expired_at).to be_a Time
    end
  end
end
