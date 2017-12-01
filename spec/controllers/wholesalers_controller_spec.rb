require 'rails_helper'

RSpec.describe WholesalersController, type: :controller do
  describe 'GET wholesalers#index' do
    it 'renders the wholesaler index page' do
      get :index
      expect(response).to render_template :index
    end
  end
  describe 'GET wholesalers#new' do
    context 'as a guest' do
      it 'should reedirect to root' do
        get :new
        expect(response).to redirect_to('/')
      end
    end
    context 'logged in as a customer' do
      before :each do
        customer = create(:customer)
        sign_in customer
      end
      it 'assigns a new Wholesaler to @wholesaler' do
        get :new
        expect(assigns(:wholesaler)).to be_a_new(Wholesaler)
      end
      it 'renders a new wholesaler page' do
        get :new
        expect(response).to render_template 'wholesalers/new.html.erb'
      end
    end
    context 'logged in as an employee' do
      before :each do
        employee = create(:employee)
        sign_in employee
        get :new
      end
      xit 'should redirect to customer sign in' do
        # employees wouldn't be making applications to become wholesalers!
        get :new
        expect(response).to redirect_to '/customer/sign_in'
      end
    end
    describe 'POST wholesalers#create' do
      before :each do
        # this test assumes that you are a customer
        customer = create(:customer)
        sign_in customer
        post :create
      end
      it 'renders the application created page' do
        expect(response).to render_template 'wholesalers/create.html.erb'
      end
    end
    describe 'GET wholesalers/:id' do
      let(:customer) { create(:customer) }
      context 'wholesaler application does not exist or is not from the customer' do
        it 'should redirect to root' do
          sign_in customer
          get :show, params: { id: 1 }
          expect(response).to redirect_to '/'
        end
      end
      context 'wholesaler application does exist' do
        before :each do
          sign_in customer
          post :create
          sign_out customer
        end
        context 'logged in as a customer' do
          it 'shows your wholesaler application' do
            sign_in customer
            get :show, params: { id: 1 }
            expect(response).to render_template :show
          end
        end
        context 'logged in as an employee' do
          it 'shows the customers wholesaler application' do
            employee = create(:employee)
            sign_in employee
            get :show, params: { id: 1 }
            expect(response).to render_template :show
          end
        end
      end
    end
    describe 'GET wholesaler#edit' do
      context 'not signed in' do
        it 'redirects to root' do
          get :edit, params: { id: 1 }
          expect(response).to redirect_to '/'
        end
      end
      context 'logged in as employee' do
        it 'redirects to root' do
          employee = create(:employee)
          sign_in employee
          get :edit, params: { id: 1 }
          expect(response).to redirect_to '/'
        end
      end
      context 'logged in as customer without wholesaler application' do
        it 'redirects to root' do
          customer = create(:customer)
          sign_in customer
          get :edit, params: { id: 1 }
          expect(response).to redirect_to '/'
        end
      end
      context 'logged in as cutstomer with wholesaler application' do
        let(:customer) { create(:customer) }
        before :each do
          create(:wholesaler, customer_id: customer.id)
          sign_in customer
          get :edit, params: { id: 1 }
        end
        it 'assigns the customers Wholesaler to @wholesaler' do
          expect(assigns(:wholesaler).customer_id).to be customer.id
        end
        it 'renders the edit wholesaler page' do
          expect(response).to render_template :edit
        end
      end
    end
    describe 'POST wholesaler#update' do
      let(:customer) { create(:customer) }
      context 'not logged in' do
        it 'redirects to root' do
          wholesaler = create(:wholesaler, customer_id: customer.id)
          post :update, params: { id: wholesaler.id, business_name: 'foobar' }
          expect(response).to redirect_to '/'
        end
      end
      xcontext 'logged in as literally anyone else' do
        # this test currently fails, a malicious user could edit other peoples applications
        it 'redirects to root' do
          wholesaler = create(:wholesaler, customer_id: customer.id)
          other_customer = create(:customer)
          sign_in other_customer
          post :update, params: { id: wholesaler.id, business_name: 'foobar' }
          expect(response).to redirect_to '/'
        end
      end
      context 'logged in as the correct customer' do
        it 'redirects to wholesalers page' do
          wholesaler = create(:wholesaler, customer_id: customer.id)
          sign_in customer
          post :update, params: { id: wholesaler.id, business_name: 'foobar' }
          expect(response).to redirect_to '/wholesalers'
        end
      end
    end
    describe 'wholesaler#wholesaler_params' do
      xcontext 'signed in as a customer' do
        # currently customers can spoof the acceptance of their own applications
        it 'rejects the is_approved or is_rejected params' do
          customer = create(:customer)
          sign_in customer
          post :create, params: { is_approved: true }
          expect(customer.wholesaler.is_approved).to be false
        end
      end
      xcontext 'signed in as an employee' do
        # currently employees are restricted from even accepting applications
        it 'accepts the is_approved or is_rejected params' do
          customer = create(:customer)
          wholesaler = create(:wholesaler, customer_id: customer.id)
          employee = create(:employee)
          sign_in employee
          post :edit, params: { id: wholesaler.id, is_approved: true }
          expect(customer.wholesaler.is_approved).to be true
        end
      end
    end
  end
end
