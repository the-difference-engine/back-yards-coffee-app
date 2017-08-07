require 'rails_helper'

RSpec.describe CartedProduct, type: :model do
  describe CartedProduct do
    it 'is valid with valid attributes' do
      carted_product = build(:carted_product)
      expect(carted_product).to be_valid
    end
  end
end
