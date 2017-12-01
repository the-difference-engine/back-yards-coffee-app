require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe "GET customers#index" do
    context "when properly authenticated" do
      before :each do
        employee = create(:employee)
        sign_in employee

        customer = create(:customer)
        sign_in customer
      end
      it "should render the index page" do
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

    # it "should redirect to '/customers/dashboard'" do
    #   patch :update, id: @customer
    #   @customer.update(address: "meow")
    #   @customer.save
    #   expect(response).to redirect_to '/customers/dashboard'
    # end
  end
end
