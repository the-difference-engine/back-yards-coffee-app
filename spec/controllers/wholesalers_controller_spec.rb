require 'rails_helper'

RSpec.describe WholesalersController, type: :controller do
  context 'logged in as a customer' do
    it 'should redirect to root' do
      customer = create(:customer)
      sign_in customer

      get :new
      expect(response).to redirect_to('/')
    end
  end
end
