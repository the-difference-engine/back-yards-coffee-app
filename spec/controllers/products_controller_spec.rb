require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe "GET products#index" do
    it "should render the index page" do
      get :index
      expect(response).to render_template :index
    end
  end
  describe "GET products#show" do
    it "should render the show page" do
      product_id = "prod_AuxRSpec01234"
      get :show, id: product_id
      expect(response).to render_template :show
      expect(assigns(:product).name).to eq("PRODUCT NAME")
    end
  end
  describe "GET products#subscriptions" do
    it "should render the subscription page" do
      get :subscriptions
      expect(response). to render_template :subscriptions
    end
  end
end
