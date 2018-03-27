require 'rails_helper'

RSpec.feature "Admin dashboard link", type: :feature do
  context 'not signed in as admin user' do
    it 'does not show a admin button' do
      visit '/wholesalers'
      expect(page).to have_link('Coffee Club', :href => '/coffee_club')
      expect(page).not_to have_link('Admin', :href => '/admin')
    end
  end
  context 'signed in as admin user' do
    it 'shows an admin button' do
      admin = create(:admin)
      visit '/employees/sign_in'
      within("#new_employee") do
        fill_in 'Email', with: 'employeedoe11@example.com'
        fill_in 'Password', with: '12345678'
      end
      click_button 'Log in'
      print page.html
      visit '/wholesalers'
      expect(page).to have_link('Admin', :href => '/admin')
    end
  end
end
