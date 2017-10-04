require 'rails_helper'

RSpec.describe Customer, type: :model do
  
  describe "assign_customer_id" do 
    it "creates a stripe customer" do
      customer = create(:customer)
      expect(customer.stripe_customer_id).to be == "cus_rSpecXxXxrSpec"
    end
  end

  describe 'guest_customer?' do
    it 'returns a Customer when it exists' do
      create(:customer, id: 1_234_567_890)
      customer = Customer.guest_customer?(1_234_567_890)
      expect(customer.id).to be 1_234_567_890
    end
    it 'returns nil when a Customer does not exist' do
      customer = Customer.guest_customer?(1_234_567_890)
      expect(customer).to be nil
    end
  end

  describe 'create_guest_cutomer' do
    it 'creates a new Customer with the passed in id and email' do
      customer = Customer.create_guest_cutomer(1_234_567_890)
      expect(customer.id).to be 1_234_567_890
      expect(customer.email).to be == '1234567890'
    end
  end

  describe 'full_name' do
    it 'returns the full name of a customer' do
      customer = create(:customer, first_name: 'John', last_name: 'Doe')
      expect(customer.full_name).to be == 'John Doe'
    end
  end

  describe 'customer_address' do
    it 'returns an adress object for a customer' do
      customer = create(:customer, address: '100 Main Street', city: 'Any City', zip_code: 12_345)
      expect(customer.customer_address).to be == { line1: '100 Main Street',
                                                   city: 'Any City',
                                                   country: 'US',
                                                   postal_code: 12_345 }
    end
  end

  describe 'default_address' do
    it 'returns an default adress if a customers address is invalid' do
      customer = create(:customer, address: '100 Main Street', city: 'Any City', zip_code: 12_345)
      expect(customer.default_address).to be == { line1: '2059 W 47th St',
                                                  city: 'Chicago',
                                                  country: 'US',
                                                  postal_code: '60609' }
    end
  end
end
