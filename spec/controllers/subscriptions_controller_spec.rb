require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe 'GET subscriptions#new' do
    context 'when properly authenticated' do
      before :each do
        employee = create(:employee)
        sign_in employee

        customer = create(:customer)
        sign_in customer
      end
      it 'shoud display current customer if signed in' do
        get :new
        expect(response).to render_template :new
      end
    end

    it 'should give a flash a warning if not signed in' do
      get :new
      expect(flash[:warning]).to be_present
    end

    it 'should redirect if not signed in' do
      get :new
      expect(response).to redirect_to '/customers/sign_up'
    end  
  end
end
