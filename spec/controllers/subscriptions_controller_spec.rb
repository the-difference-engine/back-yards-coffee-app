require 'rails_helper'
RSpec.describe SubscriptionsController, type: :controller do
  describe 'GET subscriptions#new' do
    context 'as a guest' do
      it 'should redirect to the customer registration page' do
        get :new
        expect(response).to redirect_to(new_customer_registration_path)
      end
    end
    context 'logged in as a customer' do
      before :each do
        @customer = create(:customer)
        sign_in @customer
      end
      it 'assigns current customer to @customer' do
        get :new
        expect(assigns(:customer)).to eq @customer
      end
      it 'assigns carted subscriptions to @carted_subscriptions' do
        create(:carted_subscription)
        create(:carted_subscription)
        get :new
        expect(assigns(:carted_subscriptions)).to all(be_a CartedSubscription)
      end
      it 'does not assign old carted subscriptions to @carted_subscriptions' do
        carted = create(:carted_subscription, customer_id: @customer.id)
        old_carted = create(:subscribed_subscription, customer_id: @customer.id)
        get :new
        expect(assigns(:carted_subscriptions)).to include carted
        expect(assigns(:carted_subscriptions)).not_to include old_carted
      end
    end
  end
end
