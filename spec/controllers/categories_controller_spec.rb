require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET categories#new' do
    context 'as a guest' do
      it 'should reedirect to the employee sign in page' do
        get :new
        expect(response).to redirect_to('/employees/sign_in')
      end
    end
    context 'logged in as an employee' do
      before :each do
        employee = create(:employee)
        sign_in employee
      end
      it 'assigns a new Category to @category' do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
      it 'renders new category page' do
        get :new
        expect(response).to render_template :new
      end
    end
  end
  describe 'POST categories#create' do
    before :each do
      employee = create(:employee)
      sign_in employee
    end
    it 'redirects to coffee house when category is saved' do
      post :create, name: 'category name'
      expect(response).to redirect_to('/coffee_house')
    end
    it 'redirects to new categories if it fails' do
      post :create
      expect(response).to redirect_to('/categories/new')
    end
  end
  describe 'GET categories#edit' do
    before :each do
      employee = create(:employee)
      sign_in employee
    end
    it 'assigns the requested category to @category' do
      category = create(:category)
      get :edit, id: category
      expect(assigns(:category)).to eq category
    end
    it 'redirects to edit page' do
      category = create(:category)
      get :edit, id: category
      expect(response).to render_template :edit
    end
  end
  describe 'PATCH categories#update' do
    before :each do
      employee = create(:employee)
      sign_in employee
      @category = create(:category, name: 'test')
    end
    it 'locates the requested @category' do
      patch :update, id: @category, category: attributes_for(:category)
      expect(assigns(:category)).to eq(@category)
    end
    # Having trouble with the reload or assign
    it 'changes @category attributes' do
      patch :update, id: @category, name: 'new'
      expect(assigns(:category).name).to eq 'new'
    end
    it 'redirects to coffee_house' do
      patch :update, id: @category, category: attributes_for(:category)
      expect(response).to redirect_to('/coffee_house')
    end
  end
  describe 'DELETE categories#destroy' do
    before :each do
      employee = create(:employee)
      sign_in employee
      @category = create(:category)
    end
    it 'deletes the category' do
      expect {
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end
    it 'redirects to category#index' do
      delete :destroy, id: @category
      expect(response).to redirect_to('/coffee_house')
    end
  end
end
