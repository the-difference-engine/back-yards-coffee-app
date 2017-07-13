require 'rails_helper'

RSpec.describe CartedProduct, type: :model do
  describe CartedProduct do
    it 'is valid with valid attributes' do
      carted_product = build(:carted_product)
      expect(carted_product).to be_valid
    end

    context 'method #stripe_attributes' do
      it 'assigns values to computed attributes' do
        carted_product = build(:carted_product)
        carted_product.stripe_attributes
        expect(carted_product.total_price).to eq (carted_product.quantity * carted_product.price)
      end
    end
  end
end
