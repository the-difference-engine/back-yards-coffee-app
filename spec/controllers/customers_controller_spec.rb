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

  describe 'GET categories#edit' do
    before :each do
      employee = create(:employee)
      sign_in employee

      customer = create(:customer)
      sign_in customer
    end
    it 'redirects to edit page' do
      customer = create(:customer)
      get :edit, id: customer
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH customers#update' do
    before :each do
      @customer = create(:customer)
      sign_in @customer
    end
    it 'creates a flash message: Unable to update address' do
      patch :update, id: @customer
      expect(flash[:warning]).to be_present
    end

    it "locates the requested @customer" do
      patch :update, id: @customer, customer: attributes_for(:customer)
      expect(assigns(:customer)).to eq(@customer)
    end

    it "changes @customer attributes" do
      patch :update, id: @customer,
      @customer.update(address: "meow")


      p "QQQQQQQQQQQQ"
      p @customer
      p "QQQQQQQQQQQQ"
      expect(@customer.address).to eq('meow')
    end

    xit "should redirect to '/customers/dashboard'" do
      p "QQQQQQQQQQQQ"
      p @customer
      p "QQQQQQQQQQQQ"

      patch :update, id: @customer.id
      @customer.update(address: "meow")
      @customer.save
      expect(response).to redirect_to :dashboard
    end



  end
end
