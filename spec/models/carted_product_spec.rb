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
  end
end
