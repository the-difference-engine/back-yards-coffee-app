require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  describe 'GET menus#new' do
    context 'when properly authenticated' do
      before :each do
        employee = create(:employee)
        sign_in employee
      end
      it 'should render the new page' do
        get :new
        expect(response).to render_template :new
      end
    end

  describe 'GET menus#new' do
    context 'when not authenticated' do
      it "shouldn't render the new page" do
        get :new
        expect(response).to_not render_template :new
      end
    end
  end

  describe 'POST menus#create' do
    before :each do
      employee = create(:employee)
      sign_in employee
      @category = Category.create(name: 'doesntmatter')
    end
    it 'creates a new menu item to the product' do
      post :create, params: { name: 'example', description: 'example2', price: 2.00, category_id: 1 }
      expect(Product.last.category_id).to eq(@category.id)
    end
    it 'redirects to /coffee_house' do
      post :create, params: { menu_item_params: 'example' }
      expect(response).to redirect_to('/coffee_house')
    end
  end

  describe 'GET menu#edit' do
    before :each do
      employee = create(:employee)
      category = create(:category)
      product = create(:product, category: category)
      sign_in employee
    end
    it 'loads the menu item' do
      get :edit, params: { id: 1 }
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH menus#update' do
    let(:employee) { create(:employee) }
    let(:category) { create(:category, name: "MyString") }
    let(:product) { create(:product, category: category) }
    before :each do
      sign_in employee
    end
    it 'redirects to coffee_house when legitimate' do
      patch :update, params: { id: product.id }
      expect(response).to redirect_to('/coffee_house')
    end
    it 'can locate the product' do
      patch :update, params: { id: product.id }
      expect(:product).to be_truthy
    end
    it 'can change an attribute for product' do
      patch :update, params: { id: product.id, name: "foo" }
      updated_product = Product.find(product.id)
      expect(updated_product.name).to eq 'foo'
      # expect(assigns(:product).name).to eq 'foo'
    end
  end

  describe 'DELETE menus#destroy' do
    # let(:employee) { create(:employee) }
    # let(:category) { create(:category, name: "MyString") }
    # let(:product) { create(:product, category: category) }
    before :each do
      employee = create(:employee)
      category = create(:category)
      @product = create(:product, category: category)
      sign_in employee
      #@menu = create(:menu)
    end
    it 'deletes the product from the menu' do
      expect { delete :destroy, id: @product.id }.to change{Product.count}.by(-1)
    end
    it 'redirects to menu#index' do
      delete :destroy, id: @product.id
      expect(response).to redirect_to('/coffee_house')
    end
  end

  end
end
