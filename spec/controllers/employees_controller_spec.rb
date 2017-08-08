require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do

  describe "GET pages#index" do
    context "logged in as a employee" do
      it "should render the employees#show page" do
        employee = create(:employee)
        sign_in employee
        get :show
        expect(response).to render_template :show
      end
      it "should assign a list of customers" do
        employee = create(:employee)
        customers = create_list(:customer, 3)
        sign_in employee
        get :show
        expect(assigns(:customers).count).to eq(customers.count)
      end
    end
    context "not logged in" do
      it "should redirect to employee sign in page" do
        get :show
        expect(response).to redirect_to('/employees/sign_in')
      end
    end
    context "logged in as customer" do
      it "should redirect the customer to employee sign in page" do
        customer = create(:customer)
        sign_in customer 
        get :show
        expect(response).to redirect_to('/employees/sign_in')
      end
    end
  end

end
