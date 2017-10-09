require 'rails_helper'
RSpec.describe RegistrationsController, type: :controller do
  describe "Sign Up Params" do 
    it "valid sing up parrams" do 
      delete :destroy, id: @category
      expect(response).to redirect_to('/coffee_house')
    end
  end
end
