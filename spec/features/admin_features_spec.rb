require "rails_helper"

RSpec.feature "Admin dashboard" do
    context 'visit admin page before logging in'
        before :each do
            admin = create(:admin)
            # employee = create(:employee)
            # customer = create(:customer)
        end
        it 'logs in as admin' do
            visit '/admin'
            expect(current_path).to eq(admin_root_path)
        end
    end
