describe "the signin process", :type => :feature do
  before :each do
    customer = create(:customer)
  end

  it "signs me in" do
    visit '/customers/sign_in'
    within("#new_customer") do
      fill_in 'Email', with: 'janedoe1@example.com'
      fill_in 'Password', with: '12345678'
    end
    click_button 'Log in'
    expect(page).to have_content 'Back of the Yards'
  end
end

describe "the invalid signin process", :type => :feature do
  before :each do
    customer = create(:customer)
  end

  it "doesn't sign me in with invalid credentials" do
    visit '/customers/sign_in'
    within("#new_customer") do
      fill_in 'Email', with: 'janedoe1@example.com'
      fill_in 'Password', with: '0000'
    end
    click_button 'Log in'
    expect(page).to have_content 'Log in'
  end
end