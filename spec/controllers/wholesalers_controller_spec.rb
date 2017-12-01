require 'rails_helper'

RSpec.describe WholesalersController, type: :controller do
  describe 'GET wholesalers#new' do
    context 'as a guest' do
      it 'should reedirect to root' do
        get :new
        expect(response).to redirect_to('/employees/sign_in')
      end
    end
    context 'logged in as a customer' do
      it 'should redirect to root' do
        customer = create(:customer)
        sign_in customer

        get :new
        expect(response).to redirect_to('/employees/sign_in')
      end
    end
  end
end
