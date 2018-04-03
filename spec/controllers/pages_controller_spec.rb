require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET pages#index' do
    context 'as a guest' do
      it 'should render the front page/index page' do
        allow(Stripe::Product).to receive(:list).and_return([])
        get :index
        expect(response).to render_template :index
      end
    end

    context 'logged in as a customer' do
      before :each do
        customer = create(:customer)
        sign_in customer
      end
      it 'should render the front page/index page' do
        allow(Stripe::Product).to receive(:list).and_return([])
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET pages#about' do
    it 'should render the about page' do
      get :about
      expect(response).to render_template :about
    end
  end

  describe 'GET pages#coffee_house' do
    it 'should render the coffee_house page' do
      get :coffee_house
      expect(response).to render_template :coffee_house
    end
  end

  describe 'GET pages#coffee_club' do
    it 'should render the coffee_club page' do
      allow(Stripe::Product).to receive(:list).and_return([])
      get :coffee_club
      expect(response).to render_template :coffee_club
    end
  end

  describe 'GET pages#contact' do
    it 'should renter the contact page' do
      get :contact
      expect(response).to render_template :contact
    end
  end

  describe 'GET pages#faqs' do
    it 'should render faqs page' do
      get :faqs
      expect(response).to render_template :faqs
    end
  end
end
