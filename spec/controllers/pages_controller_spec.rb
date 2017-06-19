require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET pages#index" do
    it "should render the front page/index page" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET pages#about" do
    it "should render the about page" do
      get :about
      expect(response).to render_template :about
    end
  end

  describe "GET pages#coffee_house" do 
    it "should render the coffee_house page" do 
      get :coffee_house
      expect(response).to render_template :coffee_house
    end
  end

  describe "GET pages#coffee_club" do 
    it "should render the coffee_club page" do 
      get :coffee_club
      expect(response).to render_template :coffee_club
    end
  end

end
