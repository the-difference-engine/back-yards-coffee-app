require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET customers#index' do
    context 'when properly authenticated' do
      before :each do
        employee = create(:employee)
        sign_in employee

        customer = create(:customer)
        sign_in customer
      end
      it 'should render the index page' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET customers#show' do
    before :each do
      @customer = create(:customer)
      sign_in @customer
      get :show, params: { id: @customer.id }
    end
    it 'assigns a Customer to @custer' do
      expect(assigns(:customer)).to be_a Customer
    end
    it 'assigns a Stripe::Customer to a @stripe_customer' do
      expect(assigns(:stripe_customer)).to be_a Stripe::Customer
    end
    it 'renders the show template' do
      expect(response).to render_template :show
    end
  end

  describe 'GET categories#edit' do
    before :each do
      employee = create(:employee)
      sign_in employee

      customer = create(:customer)
      sign_in customer
    end
    it 'redirects to edit page' do
      customer = create(:customer)
      get :edit, params: { id: customer }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH customers#update' do
    before :each do
      @customer = create(:customer)
      sign_in @customer
    end

    it 'creates a flash message: Unable to update address' do
      params = { id: @customer.id, customer: { state: 'IL' } }
      patch :update, params: params
      expect(flash[:warning]).to be_present
    end

    it "should redirect to '/customers/dashboard'" do
      params = { id: @customer.id, customer: { zip_code: '90210' } }
      patch :update, params: params
      expect(flash[:success]).to be_present
      expect(response).to redirect_to '/customers/dashboard'
    end
  end
end
