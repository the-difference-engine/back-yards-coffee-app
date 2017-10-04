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
    it 'returns a default adress if a customers address is invalid' do
      customer = create(:customer, address: 'Any Street', city: 'Any City', zip_code: 00_000)
      expect(customer.default_address).to be == { line1: '2059 W 47th St',
                                                  city: 'Chicago',
                                                  country: 'US',
                                                  postal_code: '60609' }
    end
  end

  describe 'valid_shipping_address?' do
    it 'returns false if the address is invalid' do
      customer = create(:customer, address: 'Any Street', city: 'Any City', zip_code: 00_000)
      VCR.use_cassette('valid_shipping_address?_invalid') do
        expect(customer.valid_shipping_address?).to be false
      end
    end
    it 'returns true if the address is valid' do
      customer = create(:customer, address: '1600 Pennsylvania Ave NW', city: 'Washington DC', zip_code: 20_500)
      VCR.use_cassette('valid_shipping_address?_valid') do
        expect(customer.valid_shipping_address?).to be true
      end
    end
  end

  describe 'carted_items' do
    it 'returns an array of carted item objects formatted for Stripe' do
      customer = create(:customer)
      create_list(:carted_product, 3, customer_id: customer.id)
      expect(customer.carted_products.count).to be 3
      expect(customer.carted_items.length).to be 3
      expect(customer.carted_items).to be == [
        { type: 'sku', parent: 'whole_bean', quantity: 2 },
        { type: 'sku', parent: 'whole_bean', quantity: 2 },
        { type: 'sku', parent: 'whole_bean', quantity: 2 }
      ]
    end
  end
end
