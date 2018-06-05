require 'rails_helper'

RSpec.describe "The Customer Signin Process", :type => :feature do
  before :each do
    customer = create(:customer)
  end

  context "with valid credentials" do
    it "logs into the customer dashboard" do
      VCR.use_cassette('stripe_get_products') do
        visit '/customers/sign_in'
        within("#new_customer") do
          fill_in 'Email', with: 'janedoe1@example.com'
          fill_in 'Password', with: '12345678'
        end
        click_button 'Log in'
        expect(page).to have_content 'My Account'
      end
    end
  end

  context "with invalid credentials" do
    it "stays on the log-in page" do
      visit '/customers/sign_in'
      within("#new_customer") do
        fill_in 'Email', with: 'janedoe1@example.com'
        fill_in 'Password', with: '0000'
      end
      click_button 'Log in'
      expect(page).to have_content 'Log in'
    end
  end

end
