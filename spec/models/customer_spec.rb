require 'rails_helper'

RSpec.describe Customer, type: :model do
  
  describe "assign_customer_id" do 
    it "creates a stripe customer" do
      customer = create(:customer)
      expect(customer.stripe_customer_id).to be == "cus_rSpecXxXxrSpec"
    end 
  end
end


