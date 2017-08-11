require 'rails_helper'

RSpec.describe CartedProduct, type: :model do
  describe CartedProduct do
    it 'is valid with valid attributes' do
      carted_product = build(:carted_product)
      expect(carted_product).to be_valid
    end

    it 'is invalid with a quantity of zero and less' do
      carted_product = build(:carted_product, quantity: 0)
      expect(carted_product).not_to be_valid
    end
    it 'is invalid with a non-numerical value' do
      carted_product = build(:carted_product, quantity: "dog")
      expect(carted_product).not_to be_valid
    end
    context "logged in as customer" do
      it 'should return the customers carted products' do
        customer = build(:customer, id: 123)
        carted_product = create(:carted_product, status: 'carted', customer_id: customer.id)
        expect(customer.carted_products.count).to eq(1)
      end
    end
  end
end
