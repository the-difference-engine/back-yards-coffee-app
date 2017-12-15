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
      employee = create(:employee)
      sign_in employee

      customer = create(:customer)
      sign_in customer
    end

    it 'should retrieve the customer' do
      get :show
      expect(response).to render_template :show
    end  
  end  

  describe 'GET customers#edit' do
    before :each do
      employee = create(:employee)
      sign_in employee

      customer = create(:customer)
      sign_in customer
    end
    it 'redirects to edit page' do
      customer = create(:customer)
      get :edit, params: {id: customer}
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH customers#update' do
    before :each do
      @customer = create(:customer)
      sign_in @customer
    end
    it 'creates a flash message: Unable to update address' do
      patch :update, params: {id: @customer}
      expect(flash[:warning]).to be_present
    end

    it "locates the requested @customer" do
      patch :update, params: { id: @customer }
      expect(assigns(:customer)).to eq(@customer)
    end

    it "changes @customer attributes" do
      patch :update, params: {id: @customer}
      @customer.update(address: "meow")
      expect(@customer.address).to eq('meow')
    end

    it "should redirect to '/customers/dashboard'" do
      patch :update, params: attributes_for(:customer).merge({
          id: @customer.id,
          address: "meow",
          zip_code: '90210'
        })
      expect(response).to redirect_to '/customers/dashboard'
      expect(Customer.find(@customer.id).address).to eq "meow"
    end
  end
end