require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do


  describe "GET categories#new" do
    it "should render a form to add new categories, if you are logged in as employee" do
      employee = create(:employee)
      sign_in employee      
      get :new
      expect(response).to render_template :new
    end

    it "should redirect you to login if you are not logged in" do
      get :new
      expect(response).to redirect_to '/employees/sign_in'
    end

    it "assigns a new Category to @category" do
      employee = create(:employee)
      sign_in employee
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end
  describe "GET categories#edit" do
    it "edits the string of the requested category" do
      employee = create(:employee)
      category = create(:category)
      sign_in employee
      get :edit, id: category 
      expect(assigns(:category)).to eq category
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new category in the database when signed in" do
        employee = create(:employee)
        category = create(:category)
        sign_in employee
        expect{
          post :create, category: category
        }.to change(Category, :count).by(1)
      end
      it "redirects to pages#coffee_house" do
        employee = create(:employee)
        category = create(:category)
        sign_in employee
        post :create,
          category: category
        expect(response).to redirect_to '/coffee_house'
      end
    end
  end



end
