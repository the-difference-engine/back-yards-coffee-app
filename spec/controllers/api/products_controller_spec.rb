require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  describe "GET api/products#index" do
    it "should respond with a status of 200" do
      get :index, format: :json
      expect(response.status).to eq 200
    end
  end
end
