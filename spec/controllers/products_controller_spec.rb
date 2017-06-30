require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
 describe "GET products#index" do
    it "should render the index page" do
      get :index
      expect(response).to render_template :index
    end
  end
end
