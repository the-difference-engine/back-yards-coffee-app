require 'rails_helper'

RSpec.describe CartedProduct, type: :model do

describe "CartedProduct" do 
  it "is valid with user_id, product_id, quantity, status, grind_id, order_id" do 
    carted_product = CartedProduct.new(
      user_id: 1,
      product_id: 1,
      quantity: 1, 
      status: "testing",
      grind_id: 3, 
      order_id: 100)
    expect(carted_product).to be_valid
  end 
end
end
