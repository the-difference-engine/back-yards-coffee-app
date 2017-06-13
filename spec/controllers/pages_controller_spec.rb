require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET pages#index" do
    it "should render the front page/index page" do
      get :index
      expect(response).to render_template :index
    end
  end

end
